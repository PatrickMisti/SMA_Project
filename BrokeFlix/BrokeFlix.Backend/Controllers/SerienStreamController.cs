using BrokeFlix.Backend.Dto;
using BrokeFlix.Backend.Services;
using BrokeFlix.Infrastructure.SerienStreamAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace BrokeFlix.Backend.Controllers;

[Route("api/[controller]")]
[ApiController]
public class SerienStreamController(SerienStreamService service, IMemoryCache cache, ILogger<SerienStreamController> logger) : ControllerBase
{
    [HttpGet("{name}")]
    [ProducesResponseType(typeof(Series), 201)]
    public async Task<ActionResult> GetDetailOfSeries(string name, CancellationToken token)
    {

        var series = await service.GetDetailOfSeries(name, token);
        if (series is null)
        {
            logger.LogWarning("Could not find series with name: {name}", name);
            return NotFound();
        }

        return Ok(series);
    }

    [HttpGet("{name}/season/{season}")]
    [ProducesResponseType(typeof(List<Media>), 201)]
    public async Task<ActionResult> GetEpisodesOfSeries(string name, int season, CancellationToken token)
    {
        var episodes = await cache.GetOrCreateAsync($"{name}-{season}", async entry =>
        {
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(1);
            return await service.GetEpisodesOfSeries(name, season, token);
        });


        if (episodes is null || !episodes.Any())
        {
            logger.LogWarning("Could not find episodes for series: {name}, season: {season}", name, season);
            return NotFound();
        }

        return Ok(episodes);
    }

    [HttpGet("{name}/season/{season}/episode/{episode}")]
    [ProducesResponseType(typeof(VideoDetails), 201)]
    public async Task<ActionResult> GetEpisodeOfSeasonDetails(string name, int season, int episode, CancellationToken token)
    {
        var detail = await cache.GetOrCreateAsync($"{name}-{season}-{episode}", async entry =>
        {
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(1);
            return await service.GetVideoDetails(name, season, episode, token);
        });

        if (detail is null)
        {
            logger.LogWarning("Could not find details for series: {name}, season: {season}, episode: {episode}", name, season, episode);
            return NotFound();
        }

        return Ok(detail);
    }

    [HttpPost("streamUrl/")]
    public async Task<ActionResult> GetStreamUrl([FromBody]StreamGrabDto streamGrab, CancellationToken token)
    {
        var stream = await service.GetStreamUrl(streamGrab.host, streamGrab.url, token);
        if (stream is null)
        {
            logger.LogWarning("Could not find url from host {0} with url {1}", streamGrab.host, streamGrab.url);
            return NotFound();
        }

        return Ok(stream);
    }

    [HttpGet("popular")]
    public async Task<ActionResult> GetPopularSeries(CancellationToken token)
    {
        var series = await cache.GetOrCreateAsync("popular_series", async entry =>
        {
            logger.LogInformation("Send Cached Data Popularity");
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(2);
            return await service.GetPopularSeries(token);
        });

        // todo retry logic in case of failure
        if (series is null || !series.Any())
        {
            logger.LogWarning("Could not find popular series");
            return NotFound();
        }
        return Ok(series);
    }

    [HttpGet("all")]
    public async Task<ActionResult<IEnumerable<GroupedSeries>>> GetAllSeries(CancellationToken token)
    {
        var series = await cache.GetOrCreateAsync("all_series", entry =>
        {
            logger.LogInformation("Send cached data all");
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(6);
            return service.GetAllSeries(token);
        });
            
        if (series is null || !series.Any())
        {
            logger.LogWarning("Could not find all series");
            return NotFound();
        }
        return Ok(series);
    }
}