using System;
using System.IO;
using UnityEngine;

public static class SaveSystem
{
    public static string SavePath => Path.Combine(Application.persistentDataPath, "life_sim_save.json");

    public static void Save(LifeSaveData data)
    {
        string json = JsonUtility.ToJson(data, true);
        File.WriteAllText(SavePath, json);
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
            return JsonUtility.FromJson<LifeSaveData>(json);
        }
        catch (Exception)
        {
            return new LifeSaveData();
        }
    }
}
