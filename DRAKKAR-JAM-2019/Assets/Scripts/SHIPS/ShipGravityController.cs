using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipGravityController : MonoBehaviour
{
    Rigidbody rb;
    BoxCollider bc;
    ShipMove sm;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        bc = GetComponent<BoxCollider>();
        sm = GetComponent<ShipMove>();
    }

    private void OnTriggerExit(Collider other)
    {
        //print("out of something");
        if(other.tag == "ring")
        {
            //print("out of ring");
            rb.useGravity = true;
            bc.enabled = false;
            rb.constraints = RigidbodyConstraints.None;
            sm.canMove = false;
            rb.mass = 100;
        }
    }
    private void OnCollisionEnter(Collision collision)
    {

    }
}
