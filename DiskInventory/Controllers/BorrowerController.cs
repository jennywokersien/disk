using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;                                                                                 // add for P2

namespace DiskInventory.Controllers
{
    public class BorrowerController : Controller
    {
        private disk_inventoryjwContext context { get; set; }                                               // add for P2
        public BorrowerController(disk_inventoryjwContext ctx)                                              // add for P2
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Borrower> borrowers = context.Borrowers.OrderBy(b => b.Lname).ThenBy(b => b.Fname).ToList();   // add for P2
            return View(borrowers);                                                                             // updated for P2
        }
    }
}
