using BrokeFlix.Infrastructure.SerienStreamAPI.Client;
using BrokeFlix.Infrastructure.SerienStreamAPI.Enums;
using BrokeFlix.Infrastructure.SerienStreamAPI.Models;

namespace BrokeFlix.Tests;

public class Tests
{

    [Test]
    public async Task Check_if_Serie_can_be_grapped()
    {
        var client = new SerienStreamClient(hostUrl: "https://aniworld.to/", site: "anime",
            ignoreCerficiateValidation: false, logger: null);
        var downloadClient = new DownloadClient();
        // Search for a series via the title
        Series series = await client.GetSeriesAsync("My Dress-Up Darling");
        Console.WriteLine($"Title: {series.Title}, Description: {series.Description}");


        // Get all episodes of a season
        Media[] episodesOfSeason1 = await client.GetEpisodesAsync("My Dress-Up Darling", 1);
        foreach (Media episode in episodesOfSeason1)
            Console.WriteLine($"[{episode.Number}] Title: {episode.Title}");

        Media[] movies = await client.GetMoviesAsync("My Dress-Up Darling");
        foreach (Media movie in movies)
            Console.WriteLine($"[{movie.Number}] Title: {movie.Title}");


        VideoDetails? episodeVideoDetails;
        try
        {
            // Get video details
            episodeVideoDetails = await client.GetEpisodeVideoInfoAsync("My Dress-Up Darling", 1, 1);
            foreach (VideoStream videoStream in episodeVideoDetails.Streams)
                Console.WriteLine(
                    $"Video Stream [{videoStream.VideoUrl}]: {videoStream.Hoster}-{videoStream.Language.Audio}-{videoStream.Language.Subtitle}");

            /*VideoDetails movieVideoDetails = await client.GetMovieVideoInfoAsync("My Dress-Up Darling", 1);
            foreach (VideoStream videoStream in movieVideoDetails.Streams)
                Console.WriteLine(
                    $"Video Stream [{videoStream.VideoUrl}]: {videoStream.Hoster}-{videoStream.Language.Audio}-{videoStream.Language.Subtitle}");*/
        }
        finally
        {
        } 

        var s = episodeVideoDetails.Streams.First();
        string streamUrl = s.Hoster switch
        {
            Hoster.VOE => await downloadClient.GetVoeStreamUrlAsync(s.VideoUrl),
            Hoster.Streamtape => await downloadClient.GetStreamtapeStreamUrlAsync(s.VideoUrl),
            Hoster.Doodstream => await downloadClient.GetDoodstreamStreamUrlAsync(s.VideoUrl),
            Hoster.Vidoza => await downloadClient.GetVidozaStreamUrlAsync(s.VideoUrl),
            _ => throw new Exception("Hoster is not supported!")
        };

        Console.WriteLine($"Direct Stream Hoster: {s.Hoster} URL: {streamUrl}");
    }

    [Test]
    public async Task Check_If_Popularity_Work()
    {
        const string HostUrl = "http://186.2.175.5/";
        const string HostPopularSeries = "/beliebte-serien";
        var client = new SerienStreamClient(hostUrl: HostUrl, site: "serie", ignoreCerficiateValidation: false, logger: null);
        var s = await client.GetPopularSeriesAsync(HostPopularSeries);

        Assert.That(s.Count(), Is.EqualTo(45));
    }

    [Test]
    public async Task Check_If_All_Series_Work()
    {
        const string HostUrl = "http://186.2.175.5/";
        const string HostPopularSeries = "/serien";
        var client = new SerienStreamClient(hostUrl: HostUrl, site: "serie", ignoreCerficiateValidation: false, logger: null);
        var s = await client.GetAllSeriesAsync(HostPopularSeries);

        Assert.That(s.Count(), Is.EqualTo(45));
    }

    [Test]
    public async Task Check_If_Search_Series_Work()
    {
        const string HostUrl = "http://186.2.175.5/";
        const string HostPopularSeries = "/serien";
        var client = new SerienStreamClient(hostUrl: HostUrl, site: "serie", ignoreCerficiateValidation: false,
            logger: null);

        var s = await client.GetSearchSeriesAsync("The Flash");

        Assert.That(s.Count(), Is.GreaterThan(0));
    }
}