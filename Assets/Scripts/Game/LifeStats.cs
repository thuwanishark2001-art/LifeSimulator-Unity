using UnityEngine;

[System.Serializable]
public class LifeStats
{
    [Range(0f, 100f)] public float energy = 100f;
    [Range(0f, 100f)] public float hunger = 100f;
    [Range(0f, 100f)] public float happiness = 75f;
    [Range(0f, 100f)] public float cleanliness = 80f;
    [Range(0f, 100f)] public float health = 100f;
    public float money = 120f;
    public int day = 1;
    public float timeOfDay = 8f;
    public string jobTitle = "Freelance Worker";
    public int jobLevel = 1;
    public string currentLocation = "Apartment";

    public void ApplyDecay(float deltaTime)
    {
        energy = Mathf.Clamp(energy - deltaTime * 1.1f, 0f, 100f);
        hunger = Mathf.Clamp(hunger - deltaTime * 1.4f, 0f, 100f);
        cleanliness = Mathf.Clamp(cleanliness - deltaTime * 0.5f, 0f, 100f);
        happiness = Mathf.Clamp(happiness - deltaTime * 0.4f, 0f, 100f);

        if (hunger < 20f)
        {
            health = Mathf.Clamp(health - deltaTime * 0.8f, 0f, 100f);
        }

        if (energy < 15f)
        {
            happiness = Mathf.Clamp(happiness - deltaTime * 0.6f, 0f, 100f);
        }
    }

    public void ApplyAction(string activity)
    {
        switch (activity)
        {
            case "Work":
                money += 30f + jobLevel * 12f;
                energy -= 18f;
                hunger -= 15f;
                happiness += 4f;
                health -= 2f;
                cleanliness -= 5f;
                jobLevel += 1;
                if (jobLevel > 10) jobTitle = "Senior Specialist";
                if (jobLevel > 15) jobTitle = "Manager";
                break;

            case "Eat":
                hunger += 30f;
                energy += 12f;
                health += 8f;
                money -= 8f;
                happiness += 5f;
                break;

            case "Sleep":
                energy += 42f;
                hunger -= 10f;
                happiness += 8f;
                timeOfDay = 7f;
                day += 1;
                break;

            case "Relax":
                happiness += 18f;
                energy -= 7f;
                hunger -= 8f;
                cleanliness -= 3f;
                break;

            case "Shower":
                cleanliness += 35f;
                happiness += 10f;
                energy -= 3f;
                break;

            default:
                break;
        }

        energy = Mathf.Clamp(energy, 0f, 100f);
        hunger = Mathf.Clamp(hunger, 0f, 100f);
        happiness = Mathf.Clamp(happiness, 0f, 100f);
        cleanliness = Mathf.Clamp(cleanliness, 0f, 100f);
        health = Mathf.Clamp(health, 0f, 100f);
    }
}
