using System.Collections;
using UnityEngine;

[ExecuteInEditMode]
public class Projectopr : MonoBehaviour
{
    [SerializeField]
    private Material material;

    [SerializeField]
    private GameObject projector;

    [Range(0.01f, 90f)] public float angle = 30f;
    public float range = 10f;

    private Camera _camera;

    private void Start()
    {
        _camera = projector.GetComponent<Camera>();
    }

    public void Update()
    {
        if (material == null)
            return;

        _camera.fieldOfView = angle;
        _camera.nearClipPlane = 0.1f;
        _camera.farClipPlane = range;

        Matrix4x4 worldToLocalMatrix = _camera.worldToCameraMatrix;
        Matrix4x4 projMatrix = _camera.projectionMatrix;
        Matrix4x4 vp = projMatrix * worldToLocalMatrix;
        material.SetMatrix("proj_vp_matrix", vp);

        // cameraコンポーネント使用しないバージョン

        // Matrix4x4 m = gameObject.transform.localToWorldMatrix;
        // Matrix4x4 porj_v = transform.worldToLocalMatrix;
        // Matrix4x4 porj_p = Matrix4x4.Perspective(angle, 1f, 0f, range);
        // Matrix4x4 porj_vp = porj_p * porj_v;
        // material.SetMatrix("proj_vp_matrix", porj_vp);


    }
}