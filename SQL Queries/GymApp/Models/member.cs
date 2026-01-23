using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class member
{
    public int member_id { get; set; }

    public string name { get; set; } = null!;

    public string email { get; set; } = null!;

    public string social_nr { get; set; } = null!;

    public string? adress { get; set; }

    public string? telefon_nr { get; set; }

    public DateTime? created_at { get; set; }

    public bool? is_active { get; set; }

    public virtual ICollection<booking> bookings { get; set; } = new List<booking>();

    public virtual ICollection<subscription> subscriptions { get; set; } = new List<subscription>();
}
