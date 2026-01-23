using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class payment
{
    public long payment_id { get; set; }

    public int booking_id { get; set; }

    public decimal amount { get; set; }

    public string payment_status { get; set; } = null!;

    public DateTime created_at { get; set; }

    public virtual booking booking { get; set; } = null!;
}
