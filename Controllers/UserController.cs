using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Recipe.Models;

namespace Recipe.Controllers
{
    public class UserController : Controller
    {
        private RecipeContext context { get; set; }

        public UserController(RecipeContext ctx) => context = ctx;

        public IActionResult Index()
        {
            List<User> users = context.Users
                .Include(u => u.Recipe)
                .ToList();

            return View(users);
        }

        public IActionResult Search(string searchKey)
        {
            var users = context.Users
                .Include(u => u.Recipe)
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchKey))
            {
                users = users.Where(u =>
                    u.Name.Contains(searchKey) ||
                    u.Recipe.Title.Contains(searchKey)
                );
            }

            return View("Index", users.ToList());
        }

        public IActionResult Delete(int id)
        {
            User us = context.Users.Find(id);

            if (us != null)
            {
                context.Users.Remove(us);
                context.SaveChanges();
            }

            return RedirectToAction("Index", "User");
        }

        [HttpGet]
public IActionResult Add()
{
    return View();
}

[HttpPost]
public IActionResult Add(User u, string recipeTitle, string recipeDescription, string recipeIngredients)
{
    var newRecipe = new global::Recipe.Models.Recipe
    {
        Title = recipeTitle,
        Description = recipeDescription,
        Ingredients = recipeIngredients
    };

    context.Recipes.Add(newRecipe);
    context.SaveChanges();

    u.RecipeId = newRecipe.RecipeId;

    context.Users.Add(u);
    context.SaveChanges();

    return RedirectToAction("Index", "User");
}

        [HttpGet]
        public IActionResult Login()
        {
            if (HttpContext.Session.GetInt32("uid") == null)
                return View();

            return View("Welcome");
        }

        [HttpPost]
        public IActionResult Login(int uid, string upass)
        {
            User u = context.Users
                .Where(u => u.UserId == uid && u.Password == upass)
                .FirstOrDefault();

            if (u != null)
            {
                HttpContext.Session.SetInt32("uid", u.UserId);
                return View("Welcome", u.Name);
            }

            return View("Login");
        }

        public IActionResult UDetails()
        {
            if (HttpContext.Session.GetInt32("uid") == null)
                return RedirectToAction("Login");

            int? userID = HttpContext.Session.GetInt32("uid");
            User u = context.Users.Find(userID);

            return View(u);
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return View("Login");
        }

        [HttpGet]
        public IActionResult ChangePassword()
        {
            if (HttpContext.Session.GetInt32("uid") == null)
                return RedirectToAction("Login");

            return View();
        }

        [HttpPost]
        public IActionResult ChangePassword(string newPass)
        {
            int? uid = HttpContext.Session.GetInt32("uid");
            User u = context.Users.Find(uid);

            u.Password = newPass;
            context.Users.Update(u);
            context.SaveChanges();

            return RedirectToAction("UDetails");
        }
    }
}
