TUNNEL_CMD := kubectl port-forward -n kubevious svc/kubevious-ui-clusterip 8080:80

default: tunnel
	sleep 2
	open http://localhost:8080

tunnel:
	pkill -f '$(TUNNEL_CMD)' || :
	$(TUNNEL_CMD) &
