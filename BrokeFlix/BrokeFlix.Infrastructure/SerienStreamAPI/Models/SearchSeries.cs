namespace BrokeFlix.Infrastructure.SerienStreamAPI.Models;

public record SearchSeries
{
    private string _title = "";
    private string _des = "";

    public string Title
    {
        get => _title;
        init => _title = value.Replace("<em>", "").Replace("</em>", "");
    }

    public string Description
    {
        get => _des; init => _des = value.Replace("<em>", "").Replace("</em>", ""); }
    public string Link { get; set; } = "";
}
