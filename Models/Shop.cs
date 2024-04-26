﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace WPF_Market.Models;

public partial class Shop
{
    public int IDShop { get; set; }

    public string NameShop { get; set; }

    public string Address { get; set; }

    public string ShopAvatar { get; set; }

    public string PhoneNumber { get; set; }

    public string Email { get; set; }

    public int? NumCustomersVisit { get; set; }

    public int? NumCustomersRate { get; set; }

    public float? Rating { get; set; }

    public string Slogan { get; set; }

    public DateTime? CreateDate { get; set; }

    public int? Visits { get; set; }

    public int? Purchases { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual Account IDShopNavigation { get; set; }

    public virtual ICollection<Inventory> Inventories { get; set; } = new List<Inventory>();
}