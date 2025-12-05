namespace BrokeFlix.Infrastructure.SerienStreamAPI.Models;

public record GroupedSeries(string Category, IEnumerable<string> Series);