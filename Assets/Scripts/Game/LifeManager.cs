using UnityEngine;
using UnityEngine.UI;

public class LifeManager : MonoBehaviour
{
    public LifeStats stats = new LifeStats();
    public LifeHUD hud;
    public bool autoSave = true;

    private float autoSaveTimer;
    private static readonly string SaveKey = "LifeSimulatorSave";

    private void Awake()
    {
        LoadGame();
        Application.targetFrameRate = 60;
    }

    private void Update()
    {
        float delta = Time.deltaTime;
        stats.ApplyDecay(delta);
        stats.timeOfDay += delta * 0.75f;

        if (stats.timeOfDay >= 24f)
        {
            stats.timeOfDay -= 24f;
            stats.day += 1;
        }

        if (hud != null)
        {
            hud.Refresh(stats);
        }

        if (autoSave)
        {
            autoSaveTimer += delta;
            if (autoSaveTimer >= 20f)
            {
                autoSaveTimer = 0f;
                SaveGame();
            }
        }
    }

    public void DoAction(string action)
    {
        stats.ApplyAction(action);
        if (hud != null)
        {
            hud.Refresh(stats);
        }
    }

    public void SaveGame()
    {
        var save = new LifeSaveData
        {
            day = stats.day,
            timeOfDay = stats.timeOfDay,
            money = stats.money,
            energy = stats.energy,
            hunger = stats.hunger,
            happiness = stats.happiness,
            cleanliness = stats.cleanliness,
            health = stats.health,
            jobTitle = stats.jobTitle,
            jobLevel = stats.jobLevel,
            currentLocation = stats.currentLocation,
            playerName = "Ava"
        };

        SaveSystem.Save(save);
    }

    public void LoadGame()
    {
        LifeSaveData save = SaveSystem.Load();
        stats.day = save.day;
        stats.timeOfDay = save.timeOfDay;
        stats.money = save.money;
        stats.energy = save.energy;
        stats.hunger = save.hunger;
        stats.happiness = save.happiness;
        stats.cleanliness = save.cleanliness;
        stats.health = save.health;
        stats.jobTitle = save.jobTitle;
        stats.jobLevel = save.jobLevel;
        stats.currentLocation = save.currentLocation;
    }
}
