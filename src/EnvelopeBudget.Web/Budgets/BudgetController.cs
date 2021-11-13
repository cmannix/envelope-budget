using EnvelopeBudget.Web.Budgets.Domain;
using Microsoft.AspNetCore.Mvc;

namespace EnvelopeBudget.Web.Budgets;

[ApiController]
[Route("[controller]")]
public class BudgetController : ControllerBase
{
    private readonly ILogger<BudgetController> _logger;

    public BudgetController(ILogger<BudgetController> logger)
    {
        _logger = logger;
    }

    [HttpPost]
    public IActionResult Create(CreateBudgetParameters parameters)
    {
        var budget = new Budget(Guid.NewGuid(), parameters.Name);
        return CreatedAtAction(nameof(Get), new { id = budget.Id }, budget);
    }

    [HttpGet]
    [Route("{id:guid}")]
    public ActionResult<Budget> Get(Guid id)
    {
        return NotFound();
    }
}