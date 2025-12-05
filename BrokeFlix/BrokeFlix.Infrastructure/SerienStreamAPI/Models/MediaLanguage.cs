using System.Runtime.Serialization;
using BrokeFlix.Infrastructure.SerienStreamAPI.Enums;

namespace BrokeFlix.Infrastructure.SerienStreamAPI.Models;

public class MediaLanguage(
    Language audio,
    Language? subtitle)
{
    public Language Audio { get; } = audio;

    public Language? Subtitle { get; } = subtitle;
}