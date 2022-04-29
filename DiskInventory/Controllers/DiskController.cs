using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;
using Microsoft.EntityFrameworkCore;

namespace DiskInventory.Controllers
{
    public class DiskController : Controller
    {
        private disk_inventoryjwContext context { get; set; }                                                   // add for P2
        public DiskController(disk_inventoryjwContext ctx)                                                      // add for P2
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Disk> disks = context.Disks.OrderBy(d => d.DiskName).Include(g => g.Genre).Include(s => s.Status).Include(t => t.DiskType).ToList();                                 // add for P2
            return View(disks);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.Genres = context.Genres.OrderBy(g => g.Description).ToList();
            ViewBag.Statuses = context.Statuses.OrderBy(s => s.Description).ToList();
            ViewBag.DiskTypes = context.DiskTypes.OrderBy(t => t.Description).ToList();
            return View("Edit", new Disk());
        }
        //public IActionResult Edit()
        //{

        //}
    }
}
