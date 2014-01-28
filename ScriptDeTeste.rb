make_classes Database.find(1)
make_classes Database.find(2)

{
:peladeiros => 
  Turma.first.jogadores.collect{|jogador|
    [jogador.nome, jogador.email]
  },
:auditagem =>
  Pessoa.all.collect{|pessoa|
    [pessoa.nome, pessoa.email]
  },
 :crm => Database.all.collect{|d| d.to_hash.to_a }

}


