using BrokeFlix.Infrastructure.SerienStreamAPI.Client;
using BrokeFlix.Infrastructure.SerienStreamAPI.Enums;
using BrokeFlix.Infrastructure.SerienStreamAPI.Models;

namespace BrokeFlix.Backend.Services;

public class SerienStreamService(ILogger<SerienStreamService> logger)
{
    const string HostUrl1 = "https://aniworld.to/";
    const string HostUrl_dep = "https://s.to/";
    const string HostUrl = "http://186.2.175.5/";
    const string Site1 = "anime";
    const string Site = "serie";
    const string HostPopularSeries = "/beliebte-serien";
    const string HostPopularAnimes = "/beliebte-animes";
    const string HostAllSeries = "/serien";

    private readonly SerienStreamClient _client = new(hostUrl: HostUrl, site: Site, ignoreCerficiateValidation: false, logger: null);

    public async Task<Series?> GetDetailOfSeries(string name, CancellationToken token)
    {
        try
        {
            
            var series = await _client.GetSeriesAsync(name, token);

            return series;
        }
        catch (Exception e)
        {
            logger.LogError("Could not load details of series: {0}", e.Message);
            return null;
        }
    }

    public async Task<List<Media>?> GetEpisodesOfSeries(string name, int episode, CancellationToken token)
    {
        try
        {
            logger.LogDebug("Load episodes of {0} season {1}", name, episode);
            var episodes = await _client.GetEpisodesAsync(name, episode, token);
            return episodes.ToList();
        }
        catch (Exception e)
        {
            logger.LogError("Could not load episodes of series: {0}", e.Message);
            return null;
        }
    }

    public async Task<VideoDetails?> GetVideoDetails(string name, int season, int episode, CancellationToken token)
    {
        try
        {
            logger.LogDebug("Load video of {0} season {1} episode {2}", name, season, episode);
            var episodes = await _client.GetEpisodeVideoInfoAsync(name, episode, season, token);
            return episodes;
        }
        catch (Exception e)
        {
            logger.LogError("Could not find video details of episode: {0}", e.Message);
            return null;
        }
    }

    public async Task<string?> GetStreamUrl(Hoster host, string url, CancellationToken token)
    {
        try
        {
            var downloadClient = new DownloadClient();
            string streamUrl = host switch
            {
                Hoster.VOE => await downloadClient.GetVoeStreamUrlAsync(url, token),
                Hoster.Streamtape => await downloadClient.GetStreamtapeStreamUrlAsync(url, token),
                Hoster.Doodstream => await downloadClient.GetDoodstreamStreamUrlAsync(url, token),
                Hoster.Vidoza => await downloadClient.GetVidozaStreamUrlAsync(url, token),
                _ => throw new Exception("Hoster is not supported!")
            };
            return streamUrl;
        }
        catch (Exception e)
        {
            logger.LogError("Could not get stream url {0}", e.Message);
            return null;
        }
    }

    public async Task<IEnumerable<Series>> GetPopularSeries(CancellationToken token)
    {
        var series = await _client.GetPopularSeriesAsync(HostPopularSeries, token);
        return series;
    }

    public async Task<IEnumerable<GroupedSeries>> GetAllSeries(CancellationToken token)
    {
        var series = await _client.GetAllSeriesAsync(HostAllSeries, token);
        return series;
    }

    public async Task<IEnumerable<SearchSeries>> SearchForAsync(string search, CancellationToken token)
    {
        try
        {
            return await _client.GetSearchSeriesAsync(search, token);
        }
        catch
        {
            return [];
        }
    }
}