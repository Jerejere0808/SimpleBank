restart:
	docker restart postgres12

postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mymy0808 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:mymy0808@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:mymy0808@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

migrateupall:
	migrate -path db/migration -database "postgresql://root:mymy0808@localhost:5432/simple_bank?sslmode=disable" -verbose up 

migratedownall:
	migrate -path db/migration -database "postgresql://root:mymy0808@localhost:5432/simple_bank?sslmode=disable" -verbose down 

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb  -destination db/mock/store.go BANK/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateupall migratedownall
	