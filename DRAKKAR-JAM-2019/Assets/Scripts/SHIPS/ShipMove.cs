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

    //[SerializeField] Transform agua;

    //ADJUST VARIABLES
    [Header("Adjust variables")]
    [SerializeField][Range(0.1f,7f)] float raycastDisplacement = 0.3f;
    public bool canMove = true;
    //Transform[] rayCastOrigins;
    Rigidbody rb;
    int layerMask;

    // Start is called before the first frame update
    void Start()
    {
        //Time.timeScale = 0.05f;
        //rayCastOrigins = GetComponentsInChildren<Transform>();
        rb = GetComponent<Rigidbody>();
        layerMask = LayerMask.GetMask("WaterSurface");
    }

    // Update is called once per frame
    void Update()
    {
        manageInputs();
        //wavePositioning();
    }

    private void FixedUpdate()
    {
        if (canMove)
        {
            //agua.Rotate(new Vector3(0f, 0f, 0.1f));
            wavePositioning();
            //FORWARD
            xSpeed += ((float)xInput - (xSpeed / X_AxisMaxSpeed)) * xAcceleration;
            xSpeed = Mathf.Clamp(xSpeed, /*-X_AxisMaxSpeed*/0f, X_AxisMaxSpeed);
            Vector3 dir = xSpeed * transform.forward.normalized;
            rb.velocity = dir;

            //SIDES
            veerSpeed += ((float)veerInput - (veerSpeed / veerMaxSpeed)) * veerAcceleration;
            veerSpeed = Mathf.Clamp(veerSpeed, -veerMaxSpeed, veerMaxSpeed);
            //transform.localRotation = Quaternion.Euler(transform.rotation.eulerAngles.x, transform.rotation.eulerAngles.y + veerSpeed, transform.rotation.eulerAngles.z);
            //float veerSpeedAux = Mathf.Clamp(veerSpeed, 0.7f, veerMaxSpeed) * Mathf.Abs(veerInput);
            //rb.angularVelocity = transform.up * veerSpeed;
            //transform.Rotate(Vector3.up, veerSpeed);
            //if (veerInput != 0)
            rb.AddTorque(transform.up * veerSpeed, ForceMode.Force);
        }
        
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
    public void wavePositioning()
    {
        RaycastHit hit;
        Vector3 correctNormal = new Vector3();
        if (Physics.Raycast(transform.position + Vector3.up * 3 + transform.forward * raycastDisplacement, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up * 3 - transform.forward * raycastDisplacement, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up * 3 + transform.forward * raycastDisplacement/2, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up * 3 - transform.forward * raycastDisplacement/2, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up * 3 + transform.right * raycastDisplacement, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up * 3 - transform.right * raycastDisplacement, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            correctNormal += hit.normal;
        }
        if (Physics.Raycast(transform.position + Vector3.up*3, /*-transform.up*/-Vector3.up, out hit, 100f, layerMask))
        {
            transform.position = hit.point;
            Vector3 auxForward = transform.forward;
            //correctNormal += hit.normal;
            correctNormal = correctNormal.normalized;
            transform.up = correctNormal;
            float angle = Vector3.Angle(auxForward, transform.forward);
            Vector3 crossProduct = Vector3.Cross(Vector3.ProjectOnPlane(auxForward, Vector3.up),
                Vector3.ProjectOnPlane(transform.forward, Vector3.up));
            if (crossProduct.y > 0)
            {
                angle = -angle;
            }
            transform.Rotate(transform.up, angle);
        } 
    }
}
