using UnityEngine;
using UnityEngine.UI;

public class LifeHUD : MonoBehaviour
{
    public Text statusText;
    public Text moneyText;
    public Text timeText;
    public Text dayText;
    public Text jobText;

    public StatBarUI energyBar;
    public StatBarUI hungerBar;
    public StatBarUI happinessBar;
    public StatBarUI cleanlinessBar;
    public StatBarUI healthBar;

    public void Refresh(LifeStats stats)
    {
        if (statusText != null)
        {
            statusText.text = GetStatusText(stats);
        }

        if (moneyText != null)
        {
            moneyText.text = "$" + Mathf.Round(stats.money).ToString();
        }

        if (timeText != null)
        {
            timeText.text = FormatTime(stats.timeOfDay);
        }

        if (dayText != null)
        {
            dayText.text = "Day " + stats.day;
        }

        if (jobText != null)
        {
            jobText.text = stats.jobTitle + " Lv." + stats.jobLevel;
        }

        if (energyBar != null) energyBar.SetValue(stats.energy, "Energy");
        if (hungerBar != null) hungerBar.SetValue(stats.hunger, "Hunger");
        if (happinessBar != null) happinessBar.SetValue(stats.happiness, "Happiness");
        if (cleanlinessBar != null) cleanlinessBar.SetValue(stats.cleanliness, "Cleanliness");
        if (healthBar != null) healthBar.SetValue(stats.health, "Health");
    }

    private static string GetStatusText(LifeStats stats)
    {
        if (stats.health < 25f) return "Health is critical. Take care of yourself.";
        if (stats.energy < 25f) return "Very tired. Rest soon.";
        if (stats.hunger < 25f) return "Hungry. Eat something.";
        if (stats.happiness < 25f) return "Needs a break and a mood boost.";
        if (stats.cleanliness < 25f) return "Dirty and uncomfortable. Shower soon.";
        return "Balanced and productive.";
    }

    private static string FormatTime(float time)
    {
        int hour = Mathf.FloorToInt(time);
        int minute = Mathf.FloorToInt((time - hour) * 60f);
        return hour.ToString("00") + ":" + minute.ToString("00");
    }
}
