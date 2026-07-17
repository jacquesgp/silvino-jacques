-- 1. CRIAÇÃO DAS TABELAS

CREATE TABLE IF NOT EXISTS public.caminhos_historia (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    local TEXT NOT NULL,
    regiao TEXT NOT NULL,
    descricao TEXT NOT NULL,
    ordem INT4 NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.trajetoria_vida (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    periodo TEXT NOT NULL,
    titulo TEXT NOT NULL,
    descricao TEXT NOT NULL,
    ordem INT4 NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Habilitar RLS (Row Level Security) - opcional, mas boa prática no Supabase
ALTER TABLE public.caminhos_historia ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trajetoria_vida ENABLE ROW LEVEL SECURITY;

-- Políticas de Acesso Público para Leitura
CREATE POLICY "Permitir leitura pública de caminhos_historia" ON public.caminhos_historia
    FOR SELECT USING (true);

CREATE POLICY "Permitir leitura pública de trajetoria_vida" ON public.trajetoria_vida
    FOR SELECT USING (true);

-- Políticas de Escrita para Usuários Autenticados (Admins)
CREATE POLICY "Permitir inserção de caminhos_historia para admins" ON public.caminhos_historia
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Permitir atualização de caminhos_historia para admins" ON public.caminhos_historia
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Permitir exclusão de caminhos_historia para admins" ON public.caminhos_historia
    FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Permitir inserção de trajetoria_vida para admins" ON public.trajetoria_vida
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Permitir atualização de trajetoria_vida para admins" ON public.trajetoria_vida
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Permitir exclusão de trajetoria_vida para admins" ON public.trajetoria_vida
    FOR DELETE USING (auth.role() = 'authenticated');


-- 2. MIGRAÇÃO DOS DADOS (SEED)

-- População de caminhos_historia
INSERT INTO public.caminhos_historia (local, regiao, descricao, ordem) VALUES
('São Borja', 'RS', 'Local de nascimento (17/02/1906). Origem de sua linhagem tradicional. Retorno como fugitivo.', 1),
('Santo Ângelo', 'RS', 'Fiscal de linha. Incidente na "Pensão do Bolinha" (25/06/1929). Julgamento.', 2),
('Santa Rosa', 'RS', 'Trabalho como fiscal de linha férrea.', 3),
('Porto Alegre', 'RS', 'Casa de Correção. Escrita da carta-poesia.', 4),
('Nonoai', 'RS', 'Refúgio na tentativa de restabelecer rede de apoio.', 5),
('Uruguaiana', 'RS', 'Chácara dos avós paternos, local de treino de tiro.', 6),
('Rio Uruguai', 'RS', 'Travessia de fronteira durante a fuga do RS.', 7),
('Chapecó', 'SC', 'Entrada no estado em rota de fuga pela divisa com o RS.', 8),
('Povoado Cameiro', 'SC', 'Local de ataque policial durante a fuga.', 9),
('Santo Tomé', 'Argentina', 'Passagem transitória pela província de Corrientes.', 10),
('Posadas', 'Argentina', 'Primeira parada na Argentina durante o périplo fronteiriço.', 11),
('Corrientes', 'Argentina', 'Viagem pela província argentina.', 12),
('Encarnación', 'Paraguai', 'Segunda parada na fuga, aprendizado do idioma Guarani.', 13),
('Bela Vista', 'MS', 'Chegada em 1929 como Valdemar Pereira. Esposa Zanyr Pinheiro. Prestígio no Exército.', 14),
('Porteiras', 'MS', 'Viveu como Valdemar Pereira trabalhando em fazendas da região.', 15),
('Maracaju', 'MS', 'Região de registro de suas façanhas na fronteira.', 16),
('Bonito', 'MS', 'Façanhas registradas. Local da morte (19/05/1939). Casa de Memória Raída.', 17),
('Porto Murtinho', 'MS', 'Comando de tropa legalista durante a Revolução de 1932.', 18),
('Rio Perdido', 'MS', 'Missão estratégica de 1932: queima da ponte para retardar tropas.', 19),
('Campo Grande', 'MS', 'Penosa viagem e tentativa de organizar comitê revolucionário.', 20),
('Bolicho Seco', 'MS', 'Ponto de passagem a caminho de Campo Grande.', 21),
('Passo Itá', 'MS', 'Próximo a São Carlos. Estadia após sair de Porteiras.', 22),
('Fazenda Aurora', 'MS', 'Local do confronto final e morte em 1939.', 23),
('Ponta Porã', 'MS', 'Pronunciado pelo assassinato de Candido Barbosa Pratt. Fuga para o Paraguai.', 24),
('Miranda', 'MS', 'Esposa Zanir (cabeleireira). Reconhecimento por ferroviário e prisão de coiteiros.', 25),
('São Paulo', 'SP', 'Tropeada de mulas. Visita à esposa. Obra "Décima Gaúcha" mimeografada em 1980.', 26);


-- População de trajetoria_vida
INSERT INTO public.trajetoria_vida (periodo, titulo, descricao, ordem) VALUES
('Início séc. XX', 'Fundação', 'The Miranda Estancia Company é fundada no Pantanal; base futura da expansão no sul do MT.', 1),
('1905 (07/Out)', 'Origem', 'Casam-se Leão Pedro Jacques e Máxima Sant''Anna em Itaroquém/RS; união que inicia a linhagem.', 2),
('1906 (17/Fev)', 'Nascimento', 'Nasce Silvino Hermiro Jacques em Camaqua/RS; origem gaúcha molda sua trajetória futura.', 3),
('1909 (08/Nov)', 'Família', 'Nasce Miguel Jacques em Itaroquém/RS; irmão que acompanha parte de sua jornada inicial.', 4),
('Adolescência', 'Formação', 'Conclui o ginásio em São Borja/RS; encerra estudos antes da vida militar e fronteiriça.', 5),
('Antes de 1929', 'Vida Militar', 'Serve na Brigada Militar/RS; alcança sargento e aprende tática, disciplina e comando.', 6),
('Antes de 1929', 'Fiscal', 'Fiscal de linha férrea; perde cargo após conflitos e início de reputação de risco.', 7),
('1929 (25/Jun)', 'O Estopim', 'Briga em cabaré de Santo Ângelo termina em morte de dois; nasce o proscrito do Sul.', 8),
('1929 (1ª Metade)', 'Tensão', 'Crimes e tensões com autoridades crescem; vira alvo principal da polícia gaúcha.', 9),
('1929 (Jun)', 'Fuga', 'Foge do Rio Grande do Sul em direção ao Brasil central; busca refúgio nas fronteiras.', 10),
('1929 (08/Ago)', 'Retorno', 'Parte de Santo Tomé/AR e retorna ao Brasil; movimenta-se entre matas e aliados.', 11),
('1929 (2º Sem)', 'Prisão e Fuga', 'Ferido e preso após emboscada; resgatado por aliados e volta a agir sob proteção.', 12),
('1929 (Final)', 'Bela Vista', 'Chega em Bela Vista-MS. Adota codinome Valdemar Pereira na fronteira inicia vida clandestina.', 13),
('1930 (02/Jul)', 'Registro Militar', 'Marinha registra incidentes na fronteira; nome de Silvino circula nos bastidores militares.', 14),
('1930 (15/Jul)', 'Monitoramento', 'Ofício reservado registra tensões em MT; autoridades acompanham seus movimentos.', 15),
('1931', 'Orcírio', 'Orcírio dos Santos serve no 10° RCI em Bela Vista; contatos futuros se aproximam.', 16),
('1931 (18/Mar)', 'Denúncia', 'Ofício de Corumbá denuncia problemas na região; O nome de Silvino é envolvido.', 17),
('1932 (Início)', 'Cenário Político', 'Cenário político se tensiona; governadores dividem apoio entre legalistas e rebeldes.', 18),
('1932 (08/Jul)', 'Reforma Klinger', 'Reforma administrativa de Klinger; reorganização militar cria brechas na fronteira.', 19),
('1932 (09/Jul)', 'Revolução', 'Eclode a Revolução Constitucionalista; Sul do MT torna-se palco de disputas armadas.', 20),
('1932 (Ago)', 'Instruções', 'Borges de Medeiros envia instruções secretas; movimentações ampliam tensão regional.', 21),
('1932', 'Comandante', 'Comanda legalistas no Sul do MT; é chamado de capitão e usa táticas de guerrilha gaúcha.', 22),
('1932', 'Rio Piripucu', 'Queima ponte no rio Piripucu para retardar Klinger; demonstra domínio territorial.', 23),
('1932', 'Divisão do 10° RCI', '10° RCI dividido politicamente; clima interno reflete crise nacional e local.', 24),
('1932', 'Adesão de Orcírio', 'Orcírio dos Santos entra no grupo de Simão Coelho; apoio a Vargas o aproxima de Silvino.', 25),
('1932', 'Ataque Rebelde', 'Constitucionalistas atacam o 10° RCI; confrontos diretos contra tropas ligadas a Silvino.', 26),
('1932', 'Resistência', 'Ofensiva segue até Porto Murtinho; legalistas se fortalecem e resistem sob Néri da Fonseca.', 27),
('1933 (Ago)', 'Extradição', 'Ordem para prender e extraditar Silvino e Argemiro Leão; refugiados no Paraguai.', 28),
('1933 (Out)', 'Manifesto', 'Manifesto universitário defende divisão de MT; região de Silvino ganha destaque político.', 29),
('1934', 'Porojukahá', 'Reputação de pistoleiro se consolida; passa a ser chamado de ''porojukahá''.', 30),
('1935', 'Ecos Comunistas', 'Contato com revolucionários de 1935; ecos comunistas atravessam sua trajetória.', 31),
('1935 (Nov)', 'Informe MT', 'Informe MT registra sua atuação; detalhes chegam ao Rio e ganham repercussão ampla.', 32),
('1935/1936', 'Mitificação', 'Ações de 1932 voltam à tona; mitificação de sua figura cresce no imaginário regional.', 33),
('1936 (Mar)', 'Invernada', 'Inverna na Fazenda Recrío junto de Adão Jacques; reduz movimentos e observa cenário.', 34),
('1937 (Fev)', 'Deserções', 'Deserções ao persegui-lo indignam comando; sua mobilidade impõe medo e respeito.', 35),
('1937', 'Estado Novo', 'Estado Novo endurece repressão; perseguição aos bandoleiros se torna prioridade.', 36),
('1938', 'Fim do Cangaço', 'Lampião é morto; auge do combate ao banditismo inspira operações contra Silvino.', 37),
('1938 (Abr)', 'Cerco', 'Relatório militar detalha buscas; cerco se fecha ao redor da fronteira pantaneira.', 38),
('1939', 'Propaganda', 'Banditismo declarado extinto; propaganda oficial tenta apagar sua lenda.', 39),
('1939 (Abr)', 'Delegacia Especial', 'Criada Delegacia Especial do Sul em Aquidauana para eliminá-lo; cerco se institucionaliza.', 40),
('1939 (30/Mar)', 'Herdeiro', 'Nasce seu filho Euclides Charão Jacques com Elodya Charão de Siqueira.', 41),
('1939 (03/Mai)', 'Sentença', 'Orcírio recebe ordem direta: eliminar, não prender; sentença assinada politicamente.', 42),
('1939 (19/Mai)', 'O Mito', 'Silvino é morto por milícia local; fim do homem, início do mito permanente da fronteira.', 43);
