new-migration:
	docker-compose exec server bash -c 'alembic revision -m "$(name)"'
migrate:
	docker-compose exec server bash -c 'alembic upgrade head'
rollback:
	docker-compose exec server bash -c 'alembic downgrade -1'
reverse:
	docker-compose exec server bash -c 'alembic downgrade base'
