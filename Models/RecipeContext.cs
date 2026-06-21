using Microsoft.EntityFrameworkCore;

namespace Recipe.Models
{
    public class RecipeContext : DbContext
    {
        public RecipeContext(DbContextOptions<RecipeContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Recipe> Recipes { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Recipe>().HasData(
                new Recipe
                {
                    RecipeId = 1,
                    Title = "Mansaf",
                    Description = "A traditional dish made with rice, meat, and yogurt sauce.",
                    Ingredients = "Rice, meat, yogurt sauce, almonds, bread"
                },
                new Recipe
                {
                    RecipeId = 2,
                    Title = "Maqluba",
                    Description = "A traditional rice dish cooked with chicken, vegetables, and spices.",
                    Ingredients = "Rice, chicken, eggplant, cauliflower, potatoes, spices"
                }
            );

            modelBuilder.Entity<User>().HasData(
                new User
                {
                    UserId = 1,
                    Name = "Walaa Abudawas",
                    Email = "w.abudawas@student.aaup.edu",
                    Password = "1234",
                    RecipeId = 1
                },
                new User
                {
                    UserId = 2,
                    Name = "Reem Daraghmeh",
                    Email = "r.daraghmeh22@student.aaup.edu",
                    Password = "5678",
                    RecipeId = 2
                }
            );
        }
    }
}
