using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightSweepManger : MonoBehaviour
{
    #region PROPERTIES
    [SerializeField] private Material m_mat;
    [SerializeField] private float m_leftLimit;
    [SerializeField] private float m_rightLimit;
    [SerializeField, Range(0, 1)] private float m_speedFactor;
    float m_xOffset;
    #endregion

    #region UNITY CALLBACKS
    private void Start()
    {
        m_xOffset = m_leftLimit;
    }

    private void Update()
    {
        m_xOffset -= Time.deltaTime * m_speedFactor;

        if(m_xOffset < m_rightLimit)
        {
            m_xOffset = m_leftLimit;
        }

        m_mat.SetTextureOffset("_LightSweepTex",new Vector2(m_xOffset,0));     
    }
    #endregion
}
