using UnityEngine;
using UnityEngine.UI;

public class StatBarUI : MonoBehaviour
{
    public Image fillImage;
    public Text labelText;
    public Text valueText;
    public string statName = "Stat";

    public void SetValue(float value, string name)
    {
        statName = name;
        float clamped = Mathf.Clamp01(value / 100f);

        if (fillImage != null)
        {
            fillImage.rectTransform.localScale = new Vector3(clamped, 1f, 1f);
        }

        if (labelText != null)
        {
            labelText.text = statName + ": ";
        }

        if (valueText != null)
        {
            valueText.text = Mathf.Round(value).ToString() + "%";
        }
    }
}
