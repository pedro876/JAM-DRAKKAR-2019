using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ClickSound : MonoBehaviour
{
    public Image playButton;
    public Image quitButton;
    public Image controlButton;


    void Start()
    {
        
    }
    void Update()
    {
        
    }
    void OnMouseOver()
    {
        playButton = GameObject.Find("button_play_active").GetComponent<Image>();
        quitButton = GameObject.Find("button_quit_active").GetComponent<Image>();
        controlButton = GameObject.Find("button_control_active").GetComponent<Image>();
    }
}
