apiVersion: apps/v1
kind: Deployment
metadata:
  name: caab-saml-mock
  namespace: laa-ccms-civil
  labels:
    app.kubernetes.io/name: caab-saml-mock
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: caab-saml-mock
  template:
    metadata:
      labels:
        app.kubernetes.io/name: caab-saml-mock
    spec:
      containers:
        - name: caab-saml-mock
          image: ${ECR_URL}:${IMAGE_TAG}
          ports:
            - containerPort: 8080
          env:
            - name: SAML_METADATA_URI
              valueFrom:
                secretKeyRef:
                  name: saml-metadata-uri
                  key: saml-metadata-uri

