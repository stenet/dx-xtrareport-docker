using Microsoft.AspNetCore.Mvc;

namespace TestReportDocker.Controllers;

[ApiController]
[Route("[controller]")]
public class ReportController : ControllerBase
{
    [HttpGet("")]
    public async Task<FileStreamResult> Get()
    {
        var report = new MyReport();
        var stream = new MemoryStream();

        await report.ExportToPdfAsync(stream);
        stream.Seek(0, SeekOrigin.Begin);

        return File(stream, "application/pdf");
    }
}