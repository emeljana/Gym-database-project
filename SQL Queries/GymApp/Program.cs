using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using GymApp.Models;


// Läs appsettings.json
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: false)
    .Build();

// Hämta connection string
var connectionString = configuration.GetConnectionString("GymDb");

var options = new DbContextOptionsBuilder<GymDbContext>()
    .UseNpgsql(connectionString)
    .Options;

using var db = new GymDbContext(options);

// Test
var classes = await db.classes.Take(5).ToListAsync();
Console.WriteLine($"Classes: {classes.Count}");
