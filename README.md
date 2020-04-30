# AutoSeg Mini-app

Projeto criado como teste para futuras etapas.

## Configurações: 

* Ruby version: 2.7.1

* Rails version: 6.0.2

* System dependencies: Ubuntu 18.04

## Como iniciar o projeto

* Seu computador deve ter preferencialmente macOS ou O.S Linux;

* Você pode utilizar o comdando `bin/setup` para configurar o que for necessário ou pode seguir os passos abaixo
{
  * Instale as dependências necessárias  definidas no    arquivo  `GemFile`, rodando o comando `bundle install`. 

  * SQLite3 é utilizado nesse projeto e para criar os bancos de dados basta rodar o comando `rails db:migrate`.

  * Talvez seja necessário o uso do comando `rails db:migrate RAILS_ENV=test`.
}

* Como foi utilizando o `rails 6`, é preferivel utilizar o comando `yarn install --check-files` para a instalação de algumas dependências.

* Você já pode utilizar o comando `rails s` para ver a aplicação funcionando no endereço `localhost:3000`.

## Testes

  Nesse projeto foi utilizado `rspec` junto com `capybara`. Caso queira executar os testes, tendo seguido os passos acima, basta executar em seu terminal o comando `rspec` ou `bundle exec rspec`.