## 1. Three styles of BDD with Rails
- Express the intention first, before the actual implementation
1. Start from mockups: Turn to view templates
2. controller tests
  - controller requires the routes and models for database setup and migration
3. model tests: drive from controller tests
4. feature specs/integration tests

inside-out vs. outside-in
models         integration
controller     controller
integration    models

## 2. HMT and HABTM

Two ways of doing many to many associations with Active Record
- prefer has_many :through

## 3. Self Referential Associations
Self referential associations with Active Record


