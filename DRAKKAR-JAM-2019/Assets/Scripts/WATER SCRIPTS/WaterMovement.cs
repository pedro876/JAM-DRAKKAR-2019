﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterMovement : MonoBehaviour
{

    [SerializeField] MeshCollider[] children;
    [SerializeField] float speed = 60f;
    ShipMove player1;
    int index = 0;
    // Start is called before the first frame update
    void Start()
    {
        player1 = GameObject.FindGameObjectWithTag("player1").GetComponent<ShipMove>();
        children = GetComponentsInChildren<MeshCollider>();
        StartCoroutine("changeObject");
    }

    IEnumerator changeObject()
    {
        //print("changing to " + index);
        for(int i = 0; i < children.Length; i++)
        {
            if (i == index) children[i].gameObject.SetActive(true);
            else children[i].gameObject.SetActive(false);
        }
        index++;
        if (index > children.Length - 1) index = 0;
       // player1.wavePositioning();
        yield return new WaitForSeconds(1f / speed);
        StartCoroutine("changeObject");
    }
}
