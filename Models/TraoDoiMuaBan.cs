﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace WPF_Market.Models;

public partial class TraoDoiMuaBan : DbContext
{
    public TraoDoiMuaBan(DbContextOptions<TraoDoiMuaBan> options)
        : base(options)
    {
    }

    public TraoDoiMuaBan()
    {
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(Properties.Settings.Default.TraoDoiMuaBan);
    }
    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Bought> Boughts { get; set; }

    public virtual DbSet<Cart> Carts { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<ImageLink> ImageLinks { get; set; }

    public virtual DbSet<Inventory> Inventories { get; set; }

    public virtual DbSet<LstProduct> LstProducts { get; set; }

    public virtual DbSet<Priority> Priorities { get; set; }

    public virtual DbSet<Shop> Shops { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.ID).HasName("PK_Account_1");

            entity.ToTable("Account");

            entity.HasIndex(e => e.UserName, "UQ__Account__C9F2845681F2AFF2").IsUnique();

            entity.Property(e => e.Email)
                .IsRequired()
                .HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.UserName)
                .IsRequired()
                .HasMaxLength(50);
        });

        modelBuilder.Entity<Bought>(entity =>
        {
            entity.HasKey(e => e.IDInvoice);

            entity.ToTable("Bought");

            entity.Property(e => e.DateBought).HasColumnType("datetime");

            entity.HasOne(d => d.IDUserNavigation).WithMany(p => p.Boughts)
                .HasForeignKey(d => d.IDUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Bought__IDUser__29AC2CE0");
        });

        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => new { e.IDUser, e.IDProduct });

            entity.ToTable("Cart");

            entity.HasOne(d => d.IDProductNavigation).WithMany(p => p.Carts)
                .HasForeignKey(d => d.IDProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Cart__IDProduct__2AA05119");

            entity.HasOne(d => d.IDUserNavigation).WithMany(p => p.Carts)
                .HasForeignKey(d => d.IDUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Cart_Product_User");
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.HasKey(e => new { e.DataTimeCreate, e.IDUser, e.IDShop }).HasName("PK__Comment__18F87060439BAE95");

            entity.ToTable("Comment");

            entity.Property(e => e.DataTimeCreate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Comment1).HasColumnName("Comment");
            entity.Property(e => e.Rate).HasDefaultValueSql("((0))");

            entity.HasOne(d => d.IDShopNavigation).WithMany(p => p.Comments)
                .HasForeignKey(d => d.IDShop)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Comment__IDShop__4924D839");

            entity.HasOne(d => d.IDUserNavigation).WithMany(p => p.Comments)
                .HasForeignKey(d => d.IDUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Comment__IDUser__4A18FC72");
        });

        modelBuilder.Entity<ImageLink>(entity =>
        {
            entity.HasKey(e => new { e.IDProduct, e.ImageLink1 });

            entity.ToTable("ImageLink");

            entity.Property(e => e.ImageLink1)
                .HasMaxLength(255)
                .HasColumnName("ImageLink");

            entity.HasOne(d => d.IDProductNavigation).WithMany(p => p.ImageLinks)
                .HasForeignKey(d => d.IDProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ImageLink_Inventory");
        });

        modelBuilder.Entity<Inventory>(entity =>
        {
            entity.HasKey(e => e.IDProduct).HasName("PK__tmp_ms_x__4290D179EFAA8E55");

            entity.ToTable("Inventory");

            entity.Property(e => e.BoughtTime).HasColumnType("datetime");
            entity.Property(e => e.Type).HasMaxLength(50);

            entity.HasOne(d => d.IDShopNavigation).WithMany(p => p.Inventories)
                .HasForeignKey(d => d.IDShop)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_IDShop");

            entity.HasMany(d => d.IDUsers).WithMany(p => p.IDProducts)
                .UsingEntity<Dictionary<string, object>>(
                    "FaVProduct",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("IDUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__FaVProduc__IDUse__2C88998B"),
                    l => l.HasOne<Inventory>().WithMany()
                        .HasForeignKey("IDProduct")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__FaVProduc__IDPro__2B947552"),
                    j =>
                    {
                        j.HasKey("IDProduct", "IDUser").HasName("PK__FaVProdu__AC3EBCE47ED2D341");
                        j.ToTable("FaVProduct");
                    });
        });

        modelBuilder.Entity<LstProduct>(entity =>
        {
            entity.HasKey(e => new { e.IDInvoice, e.IDProduct }).HasName("PK__LstProdu__C9815067155AA75B");

            entity.ToTable("LstProduct");

            entity.Property(e => e.Number).HasDefaultValueSql("((1))");

            entity.HasOne(d => d.IDInvoiceNavigation).WithMany(p => p.LstProducts)
                .HasForeignKey(d => d.IDInvoice)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__LstProduc__IDInv__2D7CBDC4");
        });

        modelBuilder.Entity<Priority>(entity =>
        {
            entity.HasKey(e => new { e.IDuser, e.IDproduct }).HasName("PK__Priority__83F81D44F8A799B9");

            entity.ToTable("Priority");

            entity.HasOne(d => d.IDproductNavigation).WithMany(p => p.Priorities)
                .HasForeignKey(d => d.IDproduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Priority__IDprod__2F650636");

            entity.HasOne(d => d.IDuserNavigation).WithMany(p => p.Priorities)
                .HasForeignKey(d => d.IDuser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Priority__IDuser__30592A6F");
        });

        modelBuilder.Entity<Shop>(entity =>
        {
            entity.HasKey(e => e.IDShop).HasName("PK__tmp_ms_x__EB360B913B87F53C");

            entity.ToTable("Shop");

            entity.Property(e => e.IDShop).ValueGeneratedNever();
            entity.Property(e => e.Address).HasMaxLength(50);
            entity.Property(e => e.CreateDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.NameShop).HasMaxLength(50);
            entity.Property(e => e.PhoneNumber).HasMaxLength(50);
            entity.Property(e => e.Rating).HasDefaultValueSql("((5))");
            entity.Property(e => e.Slogan).HasDefaultValueSql("('Sorry! This user has not written slogan!')");

            entity.HasOne(d => d.IDShopNavigation).WithOne(p => p.Shop)
                .HasForeignKey<Shop>(d => d.IDShop)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ShopID");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.ID).HasName("PK__User__3214EC07AB300865");

            entity.ToTable("User");

            entity.Property(e => e.ID).ValueGeneratedNever();
            entity.Property(e => e.Address).HasMaxLength(50);
            entity.Property(e => e.DoB).HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.IDFavProduct)
                .HasMaxLength(10)
                .IsFixedLength();
            entity.Property(e => e.IDFavShop)
                .HasMaxLength(10)
                .IsFixedLength();
            entity.Property(e => e.IdentityNum).HasMaxLength(50);
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.PhoneNumber).HasMaxLength(50);
            entity.Property(e => e.Sex).HasMaxLength(50);

            entity.HasOne(d => d.IDNavigation).WithOne(p => p.User)
                .HasForeignKey<User>(d => d.ID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UserID");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}