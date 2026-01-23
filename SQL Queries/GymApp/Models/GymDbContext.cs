using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace GymApp.Models;

public partial class GymDbContext : DbContext
{
    public GymDbContext(DbContextOptions<GymDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<_class> classes { get; set; }

    public virtual DbSet<booking> bookings { get; set; }

    public virtual DbSet<class_participant> class_participants { get; set; }

    public virtual DbSet<member> members { get; set; }

    public virtual DbSet<memberbooking> memberbookings { get; set; }

    public virtual DbSet<membersship_plan> membersship_plans { get; set; }

    public virtual DbSet<nextweekschedule> nextweekschedules { get; set; }

    public virtual DbSet<payment> payments { get; set; }

    public virtual DbSet<subscription> subscriptions { get; set; }

    public virtual DbSet<trainer> trainers { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<_class>(entity =>
        {
            entity.HasKey(e => e.class_id).HasName("classes_pkey");

            entity.Property(e => e.class_name).HasMaxLength(100);
            entity.Property(e => e.start_time).HasColumnType("timestamp without time zone");

            entity.HasOne(d => d.trainer).WithMany(p => p._classes)
                .HasForeignKey(d => d.trainer_id)
                .HasConstraintName("classes_trainer_id_fkey");
        });

        modelBuilder.Entity<booking>(entity =>
        {
            entity.HasKey(e => e.booking_id).HasName("bookings_pkey");

            entity.HasIndex(e => new { e.member_id, e.class_id }, "bookings_member_id_class_id_key").IsUnique();

            entity.Property(e => e.booking_date)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.status).HasMaxLength(100);

            entity.HasOne(d => d._class).WithMany(p => p.bookings)
                .HasForeignKey(d => d.class_id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("bookings_class_id_fkey");

            entity.HasOne(d => d.member).WithMany(p => p.bookings)
                .HasForeignKey(d => d.member_id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("bookings_member_id_fkey");
        });

        modelBuilder.Entity<class_participant>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("class_participants");

            entity.Property(e => e.class_name).HasMaxLength(100);
            entity.Property(e => e.member_name).HasMaxLength(100);
        });

        modelBuilder.Entity<member>(entity =>
        {
            entity.HasKey(e => e.member_id).HasName("members_pkey");

            entity.HasIndex(e => e.email, "members_email_key").IsUnique();

            entity.HasIndex(e => e.social_nr, "members_socialnr_key").IsUnique();

            entity.Property(e => e.member_id).HasDefaultValueSql("nextval('members_memberid_seq'::regclass)");
            entity.Property(e => e.adress).HasMaxLength(200);
            entity.Property(e => e.created_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.email).HasMaxLength(100);
            entity.Property(e => e.is_active).HasDefaultValue(true);
            entity.Property(e => e.name).HasMaxLength(100);
            entity.Property(e => e.social_nr).HasMaxLength(50);
            entity.Property(e => e.telefon_nr).HasMaxLength(50);
        });

        modelBuilder.Entity<memberbooking>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("memberbookings");

            entity.Property(e => e.booking_status).HasMaxLength(100);
            entity.Property(e => e.class_name).HasMaxLength(100);
            entity.Property(e => e.start_time).HasColumnType("timestamp without time zone");
        });

        modelBuilder.Entity<membersship_plan>(entity =>
        {
            entity.HasKey(e => e.plan_id).HasName("membersship_plans_pkey");

            entity.HasIndex(e => e.plan_name, "membersship_plans_planname_key").IsUnique();

            entity.Property(e => e.plan_id).HasDefaultValueSql("nextval('membersship_plans_planid_seq'::regclass)");
            entity.Property(e => e.isactive).HasDefaultValue(true);
            entity.Property(e => e.plan_name).HasMaxLength(100);
        });

        modelBuilder.Entity<nextweekschedule>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("nextweekschedule");

            entity.Property(e => e.class_name).HasMaxLength(100);
            entity.Property(e => e.start_time).HasColumnType("timestamp without time zone");
        });

        modelBuilder.Entity<payment>(entity =>
        {
            entity.HasKey(e => e.payment_id).HasName("payments_pkey");

            entity.HasIndex(e => e.booking_id, "idx_payments_booking_id");

            entity.Property(e => e.amount).HasPrecision(10, 2);
            entity.Property(e => e.created_at).HasDefaultValueSql("CURRENT_TIMESTAMP");

            entity.HasOne(d => d.booking).WithMany(p => p.payments)
                .HasForeignKey(d => d.booking_id)
                .HasConstraintName("fk_payments_booking");
        });

        modelBuilder.Entity<subscription>(entity =>
        {
            entity.HasKey(e => e.sub_id).HasName("subscriptions_pkey");

            entity.Property(e => e.status).HasMaxLength(100);

            entity.HasOne(d => d.member).WithMany(p => p.subscriptions)
                .HasForeignKey(d => d.member_id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("subscriptions_member_id_fkey");

            entity.HasOne(d => d.plan).WithMany(p => p.subscriptions)
                .HasForeignKey(d => d.plan_id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("subscriptions_plan_id_fkey");
        });

        modelBuilder.Entity<trainer>(entity =>
        {
            entity.HasKey(e => e.trainer_id).HasName("trainers_pkey");

            entity.HasIndex(e => e.email, "trainers_email_key").IsUnique();

            entity.Property(e => e.trainer_id).HasDefaultValueSql("nextval('trainers_trainerid_seq'::regclass)");
            entity.Property(e => e.email).HasMaxLength(100);
            entity.Property(e => e.isactive).HasDefaultValue(true);
            entity.Property(e => e.name).HasMaxLength(100);
            entity.Property(e => e.speciality).HasMaxLength(100);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
