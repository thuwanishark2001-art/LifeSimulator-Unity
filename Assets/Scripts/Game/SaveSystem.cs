using System;
using System.IO;
using UnityEngine;

public static class SaveSystem
{
    public static string SavePath => Path.Combine(Application.persistentDataPath, "life_sim_save.json");

    public static void Save(LifeSaveData data)
    {
        try
        {
            string json = JsonUtility.ToJson(data, true);
            File.WriteAllText(SavePath, json);
        }
        catch (Exception e)
        {
            Debug.LogError("Save failed: " + e.Message);
        }
    }

    public static LifeSaveData Load()
    {
        if (!File.Exists(SavePath))
        {
            return new LifeSaveData();
        }

        try
        {
            string json = File.ReadAllText(SavePath);
            var data = JsonUtility.FromJson<LifeSaveData>(json);
            return data != null ? data : new LifeSaveData();
        }
        catch (Exception e)
        {
            Debug.LogWarning("Load failed, using new save: " + e.Message);
            return new LifeSaveData();
        }
    }
}
