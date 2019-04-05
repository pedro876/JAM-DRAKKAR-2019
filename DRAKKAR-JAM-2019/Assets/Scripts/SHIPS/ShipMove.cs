using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipMove : MonoBehaviour
{
    [Header("Input variables")]
    [SerializeField] string forwardKey  = "w";
    [SerializeField] string leftwardKey = "a";
    [SerializeField] string backwardKey = "s";
    [SerializeField] string rightwardKey= "d";
    [SerializeField] string hitRightKey = "e";
    [SerializeField] string hitLeftKey  = "q";
    


    [Header("Move variables")]
    [SerializeField] float forwardAcceleration  = 1f;
    [SerializeField] float stopAcceleration     = 1f;
    [SerializeField] float veerAcceleration     = 1f;
    [SerializeField] float X_AxisMaxSpeed       = 10f;
    [SerializeField] float veerMaxSpeed         = 5f;
    int xInput = 0;
    int veerInput = 0;
    bool hitRight = false;
    bool hitLeft = false;
    //[Header("Water Positioning variables")]

    //ADJUST VARIABLES
    [SerializeField]Transform[] rayCastOrigins;
    Rigidbody rb;
    int layerMask;

    // Start is called before the first frame update
    void Start()
    {
        rayCastOrigins = GetComponentsInChildren<Transform>();
        
        rb = GetComponent<Rigidbody>();
        layerMask = LayerMask.GetMask("WaterSurface");
    }

    // Update is called once per frame
    void Update()
    {
        manageInputs();

        Vector3 correctUp = new Vector3();
        Vector3 correctPos = new Vector3();
        int count = 0;
        for(int i = 1; i < rayCastOrigins.Length; i++)
        {
            Transform t = rayCastOrigins[i];
            RaycastHit hit;
            if(Physics.Raycast(t.position, -transform.up, out hit, 50f, layerMask)){
                correctUp += hit.normal;
                correctPos += hit.point;
                count++;
            }
        }
        //print(count);
        correctUp = correctUp.normalized;
        //print(correctUp);
        correctPos = correctPos / (float)count;
        transform.position = correctPos;
        print(correctPos);
        transform.up = correctUp;

    }


    private void manageInputs()
    {
        xInput = 0;
        if (Input.GetKey(forwardKey))   xInput += 1;
        if (Input.GetKey(backwardKey))  xInput -= 1;

        veerInput = 0;
        if (Input.GetKey(rightwardKey)) veerInput += 1;
        if (Input.GetKey(leftwardKey))  veerInput -= 1;

        hitRight = Input.GetKeyDown(hitRightKey);
        hitLeft  = Input.GetKeyDown(hitLeftKey);
    }

}
