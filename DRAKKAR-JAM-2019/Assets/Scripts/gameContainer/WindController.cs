using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WindController : MonoBehaviour
{
    [Header("Wind variables")]
    [SerializeField] float windPower = 5f;
    public Vector2 windDirection = new Vector2();
    float timeForWave = 0f;
    float duringTimeForWave = 0f;

    [SerializeField] float minTimeForWave = 3f;
    [SerializeField] float maxTimeForWave = 20f;
    [SerializeField] float minDuringTimeForWave = 5f;
    [SerializeField] float maxDuringTimeForWave = 20f;

    [SerializeField] Rigidbody[] players;

    private void Start()
    {
        StartCoroutine("startWind");
    }

    IEnumerator startWind()
    {
        timeForWave = Random.Range(minTimeForWave, maxTimeForWave);
        windDirection = new Vector2();
        print("stopping wind");
        yield return new WaitForSeconds(timeForWave);
        duringTimeForWave = Random.Range(minDuringTimeForWave, maxDuringTimeForWave);
        windDirection = new Vector2(Random.Range(-187, 187), Random.Range(-187, 187)).normalized * windPower;
        print("applying wind of " + windDirection);
        yield return new WaitForSeconds(duringTimeForWave);
        StartCoroutine("startWind");
    }
}
