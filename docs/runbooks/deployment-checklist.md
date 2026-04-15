# Runbook: Deployment Checklist

> PROD downtime must not exceed **2 minutes** (ACRS retry window).
> For high-risk changes, use per-endpoint rollout.

## Pre-Deployment

- [ ] Changes reviewed and approved in PR
- [ ] CI pipeline passed (build, push to ECR, Wiz scan, Checkmarx scan)
- [ ] Deployed and validated in **DEV**
- [ ] Deployed and validated in **OAT**
- [ ] Performance impact assessed (pod sizing, resource limits unchanged or reviewed)
- [ ] Rollback plan defined (previous image tag noted)
- [ ] Team notified in channel

## Deployment (via ArgoCD)

1. ArgoCD syncs automatically on merge to `main` (or trigger manually)
2. Monitor rollout in ArgoCD UI — confirm pods become healthy
3. Watch CloudWatch: App1 and App2 error rate should not spike
4. Send a test feed through the endpoint and confirm end-to-end delivery

```bash
# Check rollout status
kubectl rollout status deployment/app1-ingestion -n feeds-dispatcher
kubectl rollout status deployment/app2-dispatch -n feeds-dispatcher
```

## Post-Deployment

- [ ] CloudWatch dashboard shows healthy metrics (error rate, latency, queue depth)
- [ ] No new DLQ messages in the 10 minutes following deployment
- [ ] Splunk shows normal ingestion pattern
- [ ] Notify team: deployment complete

## Rollback

If issues are detected within 10 minutes:

```bash
# Via ArgoCD: roll back to previous sync
argocd app rollback feeds-dispatcher-app1
argocd app rollback feeds-dispatcher-app2
```

Or update the image tag in `deploy/argocd/` to the previous version and push.
