using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WindController : MonoBehaviour
{
    [Header("Wind variables")]
    [SerializeField] float windPower = 5f;
    [HideInInspector]public Vector2 windDirection = new Vector2();
    float timeForWave = 0f;
    float duringTimeForWave = 0f;

    [SerializeField] float minTimeForWave = 3f;
    [SerializeField] float maxTimeForWave = 20f;
    [SerializeField] float minDuringTimeForWave = 5f;
    [SerializeField] float maxDuringTimeForWave = 20f;

    [SerializeField] Rigidbody[] players;
    [SerializeField] GameObject water;

    [Header("Variables del desplazamiento de agua")]

    Vector2 waterSpeed = new Vector2(0f,0f);
    [SerializeField]float maxSpeed = 10f;
    [SerializeField]float ac = 0.5f;

    private void Start()
    {
        //Time.timeScale = 0.1f;
        StartCoroutine("startWind");
    }

    public void CheckDisplacement()
    {
        waterSpeed += windDirection.normalized * ac;
        if (waterSpeed.magnitude > maxSpeed) waterSpeed = waterSpeed.normalized * maxSpeed;
        if (windDirection.magnitude < 0.01f)
        {
            waterSpeed += -waterSpeed * 0.1f;
        }
        print(waterSpeed);
        water.GetComponentInChildren<MeshRenderer>().material.SetVector("_DirectionXY", new Vector4(waterSpeed.x * Time.deltaTime, waterSpeed.y * Time.deltaTime, 0, 0));
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
