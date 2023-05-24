TUNNEL_CMD := kubectl port-forward -n argocd svc/argocd-server 8080:443

default: tunnel
	sleep 2
	open https://localhost:8080

tunnel:
	pkill -f '$(TUNNEL_CMD)' || :
	$(TUNNEL_CMD) &
