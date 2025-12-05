using BrokeFlix.Infrastructure.SerienStreamAPI.Enums;

namespace BrokeFlix.Backend.Dto;

public record StreamGrabDto(Hoster host, string url);