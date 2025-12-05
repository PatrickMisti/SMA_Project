using BrokeFlix.Infrastructure.SerienStreamAPI.Enums;

namespace BrokeFlix.Infrastructure.SerienStreamAPI.Models;

public class VideoStream(
    string videoUrl,
    Hoster hoster,
    MediaLanguage language)
{
    public string VideoUrl { get; set; } = videoUrl;

    public Hoster Hoster { get; set; } = hoster;

    public MediaLanguage Language { get; set; } = language;
}