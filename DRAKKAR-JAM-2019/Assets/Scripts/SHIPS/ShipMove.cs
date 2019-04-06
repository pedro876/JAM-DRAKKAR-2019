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
    [SerializeField] float xAcceleration  = 1f;
    [SerializeField] float veerAcceleration     = 1f;
    [SerializeField] float X_AxisMaxSpeed       = 10f;
    [SerializeField] float veerMaxSpeed         = 5f;
    int xInput = 0;
    int veerInput = 0;
    float xSpeed = 0f;
    float veerSpeed = 0f;
    bool hitRight = false;
    bool hitLeft = false;
    //[Header("Water Positioning variables")]

    [SerializeField] Transform agua;

    //ADJUST VARIABLES
    //Transform[] rayCastOrigins;
    Rigidbody rb;
    int layerMask;

    // Start is called before the first frame update
    void Start()
    {
        //rayCastOrigins = GetComponentsInChildren<Transform>();
        rb = GetComponent<Rigidbody>();
        layerMask = LayerMask.GetMask("WaterSurface");
    }

    // Update is called once per frame
    void Update()
    {
        manageInputs();
        //wavePositioning();
        //print(X_AxisMaxSpeed);
    }

    private void FixedUpdate()
    {
        agua.Rotate(new Vector3(0f, 0f, 0.1f));
        wavePositioning();
        //FORWARD
        xSpeed += ((float)xInput - (xSpeed / X_AxisMaxSpeed)) * xAcceleration ;
        xSpeed = Mathf.Clamp(xSpeed, -X_AxisMaxSpeed, X_AxisMaxSpeed);
        Vector3 dir = xSpeed * transform.forward.normalized;
        rb.velocity = dir;

        //SIDES
        veerSpeed += ((float)veerInput - (veerSpeed / veerMaxSpeed)) * veerAcceleration;
        veerSpeed = Mathf.Clamp(veerSpeed, -veerMaxSpeed, veerMaxSpeed);
        //transform.localRotation = Quaternion.Euler(transform.rotation.eulerAngles.x, transform.rotation.eulerAngles.y + veerSpeed, transform.rotation.eulerAngles.z);
        //float veerSpeedAux = Mathf.Clamp(veerSpeed, 0.7f, veerMaxSpeed) * Mathf.Abs(veerInput);
        rb.angularVelocity = transform.up * veerSpeed;
        //if (veerInput != 0)
            //rb.AddTorque(transform.up * veerSpeedAux, ForceMode.Force);
        //else
            //rb.AddTorque(transform.up * (-veerSpeedAux * 0.2f), ForceMode.Force);
        //print(veerSpeed);
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
    private void wavePositioning()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position + transform.up, -transform.up, out hit, 10f, layerMask))
        {
            //print("hit");
            transform.position = hit.point;
            
            float angle = Vector3.Angle(hit.normal, transform.up);
            //print(angle);
            Vector3 aux = Vector3.Cross(transform.up, hit.normal);
            transform.Rotate(aux, angle);
            
        } /*else if (Physics.Raycast(transform.position + transform.up, -transform.up, out hit, -10f, layerMask)){
            transform.position = hit.point;
            float angle = Vector3.Angle(hit.normal, transform.up);
            print(angle);
            Vector3 aux = Vector3.Cross(transform.up, hit.normal);
            transform.Rotate(aux, angle);
        }*/
        Debug.DrawRay(transform.position + transform.up, -transform.up, Color.red);
    }
}
