using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class LifeSimulatorBootstrap : MonoBehaviour
{
    private LifeSaveData saveData;

    private Canvas mainCanvas;
    private Image panelImage;
    private Text titleText;
    private Text statusText;
    private Text moneyText;
    private Text timeText;
    private Text dayText;
    private Text jobText;

    private Button workButton;
    private Button eatButton;
    private Button sleepButton;
    private Button relaxButton;
    private Button showerButton;
    private Button saveButton;
    private Button loadButton;

    private float autosaveTimer;

    private void Awake()
    {
        saveData = SaveSystem.Load();
        SetupCanvas();
        SetupUI();
        UpdateHud();
        Application.targetFrameRate = 60;
    }

    private void Update()
    {
        float delta = Time.deltaTime;

        saveData.timeOfDay += delta * 0.75f;
        if (saveData.timeOfDay >= 24f)
        {
            saveData.timeOfDay -= 24f;
            saveData.day += 1;
        }

        saveData.hunger = Mathf.Clamp(saveData.hunger - delta * 1.2f, 0f, 100f);
        saveData.energy = Mathf.Clamp(saveData.energy - delta * 1.1f, 0f, 100f);
        saveData.cleanliness = Mathf.Clamp(saveData.cleanliness - delta * 0.4f, 0f, 100f);
        saveData.happiness = Mathf.Clamp(saveData.happiness - delta * 0.3f, 0f, 100f);

        if (saveData.hunger < 20f)
        {
            saveData.health = Mathf.Clamp(saveData.health - delta * 0.9f, 0f, 100f);
        }

        if (saveData.energy < 15f)
        {
            saveData.happiness = Mathf.Clamp(saveData.happiness - delta * 0.6f, 0f, 100f);
        }

        autosaveTimer += delta;
        if (autosaveTimer >= 20f)
        {
            autosaveTimer = 0f;
            SaveGame();
        }

        UpdateHud();
    }

    private void SetupCanvas()
    {
        GameObject canvasObj = new GameObject("MainCanvas");
        canvasObj.transform.SetParent(transform);
        mainCanvas = canvasObj.AddComponent<Canvas>();
        mainCanvas.renderMode = RenderMode.ScreenSpaceOverlay;
        canvasObj.AddComponent<CanvasScaler>().uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
        canvasObj.AddComponent<GraphicRaycaster>();

        GameObject eventSystemObj = new GameObject("EventSystem");
        eventSystemObj.transform.SetParent(transform);
        eventSystemObj.AddComponent<EventSystem>();
        eventSystemObj.AddComponent<StandaloneInputModule>();
    }

    private void SetupUI()
    {
        GameObject panel = new GameObject("Panel");
        panel.transform.SetParent(mainCanvas.transform, false);

        RectTransform panelRect = panel.AddComponent<RectTransform>();
        panelRect.anchorMin = new Vector2(0f, 0f);
        panelRect.anchorMax = new Vector2(1f, 1f);
        panelRect.offsetMin = Vector2.zero;
        panelRect.offsetMax = Vector2.zero;

        panelImage = panel.AddComponent<Image>();
        panelImage.color = new Color(0.08f, 0.11f, 0.14f, 1f);

        titleText = CreateText(panel.transform, "Life Simulator", new Vector2(0.5f, 0.93f), 30, TextAnchor.MiddleCenter, new Color(1f, 1f, 1f, 1f));
        statusText = CreateText(panel.transform, "Your day is starting...", new Vector2(0.5f, 0.83f), 20, TextAnchor.MiddleCenter, new Color(0.7f, 0.9f, 1f, 1f));
        moneyText = CreateText(panel.transform, "$120", new Vector2(0.15f, 0.74f), 24, TextAnchor.MiddleLeft, new Color(0.9f, 0.95f, 0.4f, 1f));
        timeText = CreateText(panel.transform, "08:00", new Vector2(0.5f, 0.74f), 24, TextAnchor.MiddleCenter, new Color(1f, 1f, 1f, 1f));
        dayText = CreateText(panel.transform, "Day 1", new Vector2(0.84f, 0.74f), 24, TextAnchor.MiddleRight, new Color(1f, 1f, 1f, 1f));
        jobText = CreateText(panel.transform, "Freelance Worker", new Vector2(0.5f, 0.67f), 20, TextAnchor.MiddleCenter, new Color(0.8f, 0.8f, 0.8f, 1f));

        CreateStatRow(panel.transform, "Energy", 0.12f, 0.52f, 0.85f, 0.10f, ref saveData.energy);
        CreateStatRow(panel.transform, "Hunger", 0.12f, 0.40f, 0.85f, 0.10f, ref saveData.hunger);
        CreateStatRow(panel.transform, "Happiness", 0.12f, 0.28f, 0.85f, 0.10f, ref saveData.happiness);
        CreateStatRow(panel.transform, "Cleanliness", 0.12f, 0.16f, 0.85f, 0.10f, ref saveData.cleanliness);
        CreateStatRow(panel.transform, "Health", 0.12f, 0.04f, 0.85f, 0.10f, ref saveData.health);

        workButton = CreateButton(panel.transform, "Work", new Vector2(0.18f, 0.25f), new Vector2(0.22f, 0.10f), 18);
        eatButton = CreateButton(panel.transform, "Eat", new Vector2(0.40f, 0.25f), new Vector2(0.22f, 0.10f), 18);
        sleepButton = CreateButton(panel.transform, "Sleep", new Vector2(0.62f, 0.25f), new Vector2(0.22f, 0.10f), 18);
        relaxButton = CreateButton(panel.transform, "Relax", new Vector2(0.18f, 0.12f), new Vector2(0.22f, 0.10f), 18);
        showerButton = CreateButton(panel.transform, "Shower", new Vector2(0.40f, 0.12f), new Vector2(0.22f, 0.10f), 18);
        saveButton = CreateButton(panel.transform, "Save", new Vector2(0.62f, 0.12f), new Vector2(0.22f, 0.10f), 18);
        loadButton = CreateButton(panel.transform, "Load", new Vector2(0.84f, 0.12f), new Vector2(0.12f, 0.10f), 16);

        workButton.onClick.AddListener(WorkAction);
        eatButton.onClick.AddListener(EatAction);
        sleepButton.onClick.AddListener(SleepAction);
        relaxButton.onClick.AddListener(RelaxAction);
        showerButton.onClick.AddListener(ShowerAction);
        saveButton.onClick.AddListener(SaveGame);
        loadButton.onClick.AddListener(LoadGame);
    }

    private void CreateStatRow(Transform parent, string label, float xMin, float yMin, float width, float height, ref float value)
    {
        GameObject bg = new GameObject(label + "BarBG");
        bg.transform.SetParent(parent, false);
        RectTransform bgRect = bg.AddComponent<RectTransform>();
        bgRect.anchorMin = new Vector2(xMin, yMin);
        bgRect.anchorMax = new Vector2(xMin + width, yMin + height);
        bgRect.offsetMin = Vector2.zero;
        bgRect.offsetMax = Vector2.zero;
        Image bgImage = bg.AddComponent<Image>();
        bgImage.color = new Color(0.2f, 0.2f, 0.2f, 1f);

        GameObject fill = new GameObject(label + "BarFill");
        fill.transform.SetParent(bg.transform, false);
        RectTransform fillRect = fill.AddComponent<RectTransform>();
        fillRect.anchorMin = Vector2.zero;
        fillRect.anchorMax = new Vector2(1f, 1f);
        fillRect.offsetMin = new Vector2(3f, 3f);
        fillRect.offsetMax = new Vector2(-3f, -3f);
        Image fillImage = fill.AddComponent<Image>();
        fillImage.color = new Color(0.2f, 0.8f, 0.5f, 1f);

        GameObject labelTextGo = new GameObject(label + "Text");
        labelTextGo.transform.SetParent(parent, false);
        Text rowLabel = labelTextGo.AddComponent<Text>();
        rowLabel.font = Resources.GetBuiltinResource<Font>("Arial.ttf");
        rowLabel.text = label + ": 100%";
        rowLabel.fontSize = 16;
        rowLabel.alignment = TextAnchor.MiddleLeft;
        rowLabel.color = new Color(1f, 1f, 1f, 1f);
        RectTransform rowLabelRect = labelTextGo.GetComponent<RectTransform>();
        rowLabelRect.anchorMin = new Vector2(xMin, yMin + 0.25f);
        rowLabelRect.anchorMax = new Vector2(xMin + 0.3f, yMin + 0.9f);
        rowLabelRect.offsetMin = Vector2.zero;
        rowLabelRect.offsetMax = Vector2.zero;

        var valueText = labelTextGo.AddComponent<Text>();
        valueText.font = Resources.GetBuiltinResource<Font>("Arial.ttf");
        valueText.text = "100%";
        valueText.fontSize = 16;
        valueText.alignment = TextAnchor.MiddleRight;
        valueText.color = new Color(1f, 1f, 1f, 1f);
        valueText.rectTransform.anchorMin = new Vector2(xMin + 0.75f, yMin + 0.25f);
        valueText.rectTransform.anchorMax = new Vector2(xMin + width, yMin + 0.95f);
        valueText.rectTransform.offsetMin = Vector2.zero;
        valueText.rectTransform.offsetMax = Vector2.zero;

        // Add a controlled data model reference by storing through a custom component.
        bg.gameObject.AddComponent<StatBar>().SetFill(fillImage, rowLabel, valueText, label);
    }

    private Text CreateText(Transform parent, string text, Vector2 anchor, int fontSize, TextAnchor alignment, Color color)
    {
        GameObject textObj = new GameObject("Text");
        textObj.transform.SetParent(parent, false);

        Text uiText = textObj.AddComponent<Text>();
        uiText.font = Resources.GetBuiltinResource<Font>("Arial.ttf");
        uiText.text = text;
        uiText.fontSize = fontSize;
        uiText.alignment = alignment;
        uiText.color = color;

        RectTransform rect = textObj.GetComponent<RectTransform>();
        rect.anchorMin = new Vector2(anchor.x - 0.12f, anchor.y - 0.05f);
        rect.anchorMax = new Vector2(anchor.x + 0.12f, anchor.y + 0.05f);
        rect.offsetMin = Vector2.zero;
        rect.offsetMax = Vector2.zero;

        return uiText;
    }

    private Button CreateButton(Transform parent, string label, Vector2 anchor, Vector2 size, int fontSize)
    {
        GameObject buttonObj = new GameObject(label + "Button");
        buttonObj.transform.SetParent(parent, false);

        RectTransform rect = buttonObj.AddComponent<RectTransform>();
        rect.anchorMin = new Vector2(anchor.x - size.x * 0.5f, anchor.y - size.y * 0.5f);
        rect.anchorMax = new Vector2(anchor.x + size.x * 0.5f, anchor.y + size.y * 0.5f);
        rect.offsetMin = Vector2.zero;
        rect.offsetMax = Vector2.zero;

        Image image = buttonObj.AddComponent<Image>();
        image.color = new Color(0.2f, 0.45f, 0.7f, 1f);

        Button button = buttonObj.AddComponent<Button>();
        button.targetGraphic = image;

        GameObject textObj = new GameObject("Label");
        textObj.transform.SetParent(buttonObj.transform, false);

        Text text = textObj.AddComponent<Text>();
        text.text = label;
        text.font = Resources.GetBuiltinResource<Font>("Arial.ttf");
        text.fontSize = fontSize;
        text.alignment = TextAnchor.MiddleCenter;
        text.color = Color.white;

        RectTransform textRect = textObj.GetComponent<RectTransform>();
        textRect.anchorMin = Vector2.zero;
        textRect.anchorMax = Vector2.one;
        textRect.offsetMin = Vector2.zero;
        textRect.offsetMax = Vector2.zero;

        return button;
    }

    private void UpdateHud()
    {
        moneyText.text = "$" + Mathf.Round(saveData.money).ToString();
        timeText.text = FormatTime(saveData.timeOfDay);
        dayText.text = "Day " + saveData.day;
        jobText.text = saveData.jobTitle + " Lv." + saveData.jobLevel;

        string status = "Balanced and ready.";
        if (saveData.energy < 25f) status = "Very tired.";
        if (saveData.hunger < 25f) status = "Hungry and low on focus.";
        if (saveData.happiness < 25f) status = "Needs a break.";
        if (saveData.health < 25f) status = "Health is getting risky.";
        statusText.text = status;

        UpdateStatDisplay("Energy", saveData.energy);
        UpdateStatDisplay("Hunger", saveData.hunger);
        UpdateStatDisplay("Happiness", saveData.happiness);
        UpdateStatDisplay("Cleanliness", saveData.cleanliness);
        UpdateStatDisplay("Health", saveData.health);
    }

    private void UpdateStatDisplay(string statName, float value)
    {
        StatBar[] statBars = FindObjectsOfType<StatBar>();
        foreach (var bar in statBars)
        {
            if (bar.DisplayName == statName)
            {
                bar.SetValue(value);
            }
        }
    }

    private static string FormatTime(float hourFloat)
    {
        int hour = Mathf.FloorToInt(hourFloat);
        int minute = Mathf.FloorToInt((hourFloat - hour) * 60f);
        return hour.ToString("00") + ":" + minute.ToString("00");
    }

    private void WorkAction()
    {
        saveData.money += 30f + saveData.jobLevel * 12f;
        saveData.energy -= 18f;
        saveData.hunger -= 14f;
        saveData.happiness += 4f;
        saveData.health -= 2f;
        saveData.cleanliness -= 4f;
        saveData.jobLevel += 1;
        if (saveData.jobLevel > 10) saveData.jobTitle = "Senior Specialist";
        if (saveData.jobLevel > 15) saveData.jobTitle = "Manager";
        statusText.text = "You worked hard and earned money.";
    }

    private void EatAction()
    {
        saveData.hunger += 30f;
        saveData.energy += 12f;
        saveData.health += 8f;
        saveData.money -= 8f;
        saveData.happiness += 5f;
        statusText.text = "Fresh food restored your energy.";
    }

    private void SleepAction()
    {
        saveData.energy += 40f;
        saveData.hunger -= 10f;
        saveData.happiness += 8f;
        saveData.timeOfDay = 7f;
        saveData.day += 1;
        statusText.text = "A full rest reset your body and mind.";
    }

    private void RelaxAction()
    {
        saveData.happiness += 18f;
        saveData.energy -= 7f;
        saveData.hunger -= 8f;
        saveData.cleanliness -= 3f;
        statusText.text = "You took a quiet moment to relax.";
    }

    private void ShowerAction()
    {
        saveData.cleanliness += 35f;
        saveData.happiness += 10f;
        saveData.energy -= 3f;
        statusText.text = "You feel refreshed and cleaner.";
    }

    public void SaveGame()
    {
        SaveSystem.Save(saveData);
        statusText.text = "Game saved.";
    }

    public void LoadGame()
    {
        saveData = SaveSystem.Load();
        UpdateHud();
        statusText.text = "Game loaded.";
    }
}

public class StatBar : MonoBehaviour
{
    public string DisplayName { get; private set; }
    private Image fillImage;
    private Text labelText;
    private Text valueText;

    public void SetFill(Image image, Text label, Text value, string displayName)
    {
        fillImage = image;
        labelText = label;
        valueText = value;
        DisplayName = displayName;
    }

    public void SetValue(float value)
    {
        if (fillImage == null) return;

        float clamped = Mathf.Clamp01(value / 100f);
        fillImage.rectTransform.localScale = new Vector3(clamped, 1f, 1f);

        if (labelText != null)
            labelText.text = DisplayName + ": " + Mathf.Round(value).ToString() + "%";

        if (valueText != null)
            valueText.text = Mathf.Round(value).ToString() + "%";
    }
}

