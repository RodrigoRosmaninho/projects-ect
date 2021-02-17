import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

 /*

    Métodos Probabilísticos para Engenharia Informática - 2018/2019
    Universidade de Aveiro

    Trabalho Prático
    Entregue a 11/12/2018

    Efetuado por:
    Rodrigo Rosmaninho - Nº MEC: 88802
    André Alves - Nº MEC: 88811

 */

public class Main {
    static JFrame frame;
    static DirectoryTools directoryTools;
    static JList list;
    static File assets;
    static ActionListener start;
    static JLabel numShingles;

    public static void main(String[] args) throws IOException {
        // Buscar pasta de imagens 'assets'
        assets = new File("assets");

        // Establecer título do ProgressMonitor que vai ser usado para mostrar o progresso da leitura do diretório
        UIManager.put("ProgressMonitor.progressText", "Leitura do Diretório");
        UIManager.put("OptionPane.cancelButtonText", "Cancelar");

        frame = new JFrame();
        frame.setContentPane(getStartPanel());
        frame.setTitle("Directory Tools");
        File f = new File(assets, "logo.png");
        try {
            Image i = ImageIO.read(f);
            frame.setIconImage(i);
        } catch (IOException e) {
            e.printStackTrace();
        }
        frame.setSize(610,560);
        frame.setResizable(false);
        // Terminar programa quando o utilizador fecha a janela
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }

    // JPanel inicial com informação sobre o projeto e botão para iniciar
    public static JPanel getStartPanel() throws IOException{
        // Listener do botão 'Começar'
        start = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                // Abrir popup de escolha de diretório
                File dir = getDirectory();
                if(dir == null) return;

                // Mostrar JPanel com lista de ficheiros e afins
                frame.setContentPane(getMainPanel(dir));
                frame.validate();
                frame.repaint();

                // Ler diretório. Try/catch necessário devido a possível IOException
                try {
                    parseDir(dir);
                } catch (Exception e){
                   e.printStackTrace();
                }
            }
        };

        JPanel panel = new JPanel(new BorderLayout());

        JPanel top = new JPanel();
        top.add(new JLabel("Métodos Probabilísticos para Engenharia Informática - DETI - Universidade de Aveiro"));

        JLabel title = new JLabel("Directory Tools");
        Font f = title.getFont();
        String fam = f.getFamily();
        int style = f.getStyle();
        title.setFont(new Font(fam,style,32));
        title.setBorder(new EmptyBorder(100,0,0,0));
        top.add(title);

        top.setBorder(new EmptyBorder(0,0,20,0));

        JButton button = new JButton("Começar");
        button.addActionListener(start);

        JPanel center = new JPanel();
        center.add(new JLabel("Esta ferramenta permite verificar se ficheiros pertencem a um determinado diretório"));
        center.add(new JLabel("E, se pertencerem, quais são, mesmo que os seus nomes sejam diferentes."));
        center.add(new JLabel("Para além disso, é também capaz de encontrar ficheiros duplicados no diretório."));
        center.add(new JLabel("Utiliza, para estes fins, CountingBloomFilter, MinHashing, e Locality Sensitive Hashing."));
        center.add(new JLabel("Um Contador Estocástico também é incluído."));
        center.add(new JLabel("                                                                                     "));
        center.add(new JLabel("Para minimizar o tempo de espera, recomenda-se diretórios de tamanho até 20MB"));

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(button);
        center.add(buttonPanel);

        JPanel bottom = new JPanel(new GridLayout(3,1));
        bottom.add(new JLabel("Projeto realizado por:"));
        bottom.add(new JLabel("Rodrigo Rosmaninho - NºMec 88802"));
        bottom.add(new JLabel("André Alves - NºMec 88811"));

        panel.add(top, BorderLayout.PAGE_START);
        panel.add(center, BorderLayout.CENTER);
        panel.add(bottom, BorderLayout.PAGE_END);

        return panel;
    }

    // Abrir popup de escolha de diretório e devolver a seleção do utilizador
    public static File getDirectory(){
        JFileChooser chooser = new JFileChooser();
        chooser.setDialogTitle("Escolha de Diretório");
        chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        chooser.showOpenDialog(frame);

        File dir = chooser.getSelectedFile();
        if(dir == null) return null;
        if(!(dir.isDirectory() && dir.canRead())) {
            handleError("O diretório selecionado é inválido ou não pode ser lido!");
            return null;
        }

        return dir;
    }

    // Abrir popup de escolha de ficheiro e devolver a seleção do utilizador
    public static File getFile() {
        JFileChooser chooser = new JFileChooser();
        chooser.setDialogTitle("Escolha de Ficheiro");
        chooser.showOpenDialog(frame);

        File f = chooser.getSelectedFile();
        if(f == null) return null;
        if(!(f.isFile() && f.canRead())) {
            handleError("O ficheiro selecionado é inválido ou não pode ser lido!");
            return null;
        }

        return f;
    }

    // Método de leitura e parsing do diretório selecionado
    public static void parseDir(File dir) {
        File[] directory = dir.listFiles();
        int fileNumber = 0;
        // Verificar quantos ficheiros (passiveis de serem lidos) existem no diretório
        for (File f : directory) if (f.isFile() && f.canRead()) fileNumber++;
        if (fileNumber == 0) handleFatalError("O diretório escolhido não possui nenhum ficheiro que possa ser lido!");

        directoryTools = new DirectoryTools(fileNumber, 0.001); // 0.1%

        // Mostrar ProgressMonitor
        ProgressMonitor pm = new ProgressMonitor(frame, "Por favor aguarde enquanto os ficheiros são lidos e adicionados ao Bloom Filter e à Matriz de Assinaturas", "Inicializando...", 0, fileNumber + 1);
        pm.setMillisToDecideToPopup(5);
        pm.setMillisToPopup(5);

        final int fNumber = fileNumber;
        // Criar nova Thread para que os elementos do UI possam ser atualizados e utilizados enquanto se lê o diretório
        Thread thread = new Thread(() -> {
            long sizeCount = 0;
            int fileCount = 1;
            for (File f : directory) {
                // Se o utilizador carregou em 'Cancelar', terminar programa
                if(pm.isCanceled()) System.exit(2);

                long fileSize = f.length();
                // Para evitar OutOfMemoryError, limitar leitura do diretório aos primeiros 100MBs
                if (f.isFile() && f.canRead() && sizeCount + fileSize <= 100000000) {
                    // Update do ProgressMonitor a cada ficheiro lido
                    pm.setNote("A ler ficheiro " + fileCount + " de " + fNumber);
                    pm.setProgress(fileCount);

                    if(pm.isCanceled()) System.exit(2);
                    try {
                        // Inserir ficheiro no CountingBloomFilter e na Matriz de Assinaturas
                        directoryTools.insert(f);
                        // Atualizar JList para refletir novo elemento adicionado
                        update();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if(pm.isCanceled()) System.exit(2);

                    fileCount++;
                    sizeCount += fileSize;
                }
            }
            pm.setProgress(fileCount);
        });

        thread.start();
    }

    // Mostrar popup com mensagem de erro
    public static void handleError(String message){
        JOptionPane.showMessageDialog(frame, message, "Erro", JOptionPane.ERROR_MESSAGE);
    }

    // Mostrar popup com mensagem de erro e terminar o programa
    public static void handleFatalError(String message){
        handleError(message);
        System.exit(1);
    }

    // JPanel principal com Lista de ficheiros, botão de remoção, e botão de escolha de ficheiro a verificar
    public static JPanel getMainPanel(File dir){
        // Listener do botão 'Escolher Ficheiro'
        ActionListener verifyListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                JButton b = (JButton) actionEvent.getSource();
                String text = b.getText();
                b.setEnabled(false);
                b.setText("Aguarde...");

                // Abrir popup de escolha de ficheiro
                File f = getFile();
                if(f == null) {
                    b.setEnabled(true);
                    b.setText(text);
                    return;
                }

                try {
                    // Verificar se o ficheiro pertence ao CountingBloomFilter e, se sim, qual é o ficheiro do diretório mais semelhante a ele
                    Verify results = directoryTools.verifyFile(f);
                    b.setEnabled(true);
                    b.setText(text);

                    ImageIcon icon;
                    String message;

                    // Se não pertence
                    if(!results.isInBloomFilter()) {
                        icon = new ImageIcon(new File(assets, "fail.png").getAbsolutePath());
                        if(results.getMostSimilar().getJaccardDistance() <= 0.30) message = String.format("O ficheiro selecionado não pertence ao diretório.\nNo entanto, é semelhante ao ficheiro:\n%s\n\nDistância de Jaccard: %.4f", results.getMostSimilar().getDoc(), results.getMostSimilar().getJaccardDistance());
                        else message = "O ficheiro selecionado não pertence ao diretório,\nnem é suficientemente semelhante a algum dos ficheiros que pertence.";
                    }
                    // Se pertence
                    else {
                        icon = new ImageIcon(new File(assets, "success.png").getAbsolutePath());
                        message = String.format("O ficheiro selecionado pertence ao diretório.\nProvavelmente corresponde ao ficheiro:\n%s\n\nDistância de Jaccard: %.4f", results.getMostSimilar().getDoc(), results.getMostSimilar().getJaccardDistance());
                    }

                    JOptionPane.showMessageDialog(frame, message, "Resultados", JOptionPane.INFORMATION_MESSAGE, icon);

                } catch (IOException e) {
                    b.setEnabled(true);
                    b.setText(text);
                    e.printStackTrace();
                }
            }
        };

        // Listener do botão 'Encontrar Duplicados'
        ActionListener duplicatesListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                List<Duplicates> results = directoryTools.getDuplicates();
                ImageIcon icon;
                if(results.size() == 0) {
                    icon = new ImageIcon(new File(assets, "success.png").getAbsolutePath());
                    JOptionPane.showMessageDialog(frame, "O diretório não possui ficheiros duplicados.", "Resultados", JOptionPane.INFORMATION_MESSAGE, icon);
                }
                else {
                    icon = new ImageIcon(new File(assets, "fail.png").getAbsolutePath());
                    String res = "";
                    for(Duplicates d : results){
                        res += "\n" + d.getDoc1() + " == " + d.getDoc2() + "\nDistância de Jaccard: " + d.getJaccardDistance() + "\n";
                    }
                    String size = "";
                    if(results.size() == 1) size = "1 par";
                    else size = results.size() + " pares";
                    JOptionPane.showMessageDialog(frame, "O diretório possui " + size + " de ficheiros duplicados.\n" + res, "Resultados", JOptionPane.INFORMATION_MESSAGE, icon);
                }
            }
        };

        // Listener do botão 'Contar'
        ActionListener countListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    String word = "vez";
                    int res = directoryTools.count(new File(dir, ((Document) (list.getSelectedValue())).getName()));
                    if(res > 1) word = "vezes";
                    JOptionPane.showMessageDialog(frame, "Este ficheiro está presente " + res + " " + word + " no diretório.", "Resultados da Contagem", JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException e){
                    e.printStackTrace();
                }
            }
        };

        // Listener do botão 'Eliminar'
        ActionListener deleteListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    directoryTools.remove(new File(dir, ((Document) (list.getSelectedValue())).getName()));
                    update();
                } catch (IOException e){
                    e.printStackTrace();
                }
            }
        };

        JPanel panel = new JPanel(new BorderLayout());

        JPanel main = new JPanel(new GridLayout(1,2));

        JPanel left = new JPanel(new BorderLayout());

        JPanel listTitle = new JPanel();
        listTitle.add(new JLabel("Lista de ficheiros"));
        left.add(listTitle, BorderLayout.PAGE_START);

        List<Document> docList = new ArrayList<>();
        Document[] docArray = docList.toArray(new Document[docList.size()]);
        list = new JList(docArray);
        // Adicionar ScrollPane à lista
        left.add(new JScrollPane(list), BorderLayout.CENTER);

        JPanel list_bottom = new JPanel(new GridLayout(1,2));

        JButton count = new JButton("Contar");
        count.addActionListener(countListener);
        count.setEnabled(false);
        list_bottom.add(count);

        JButton delete = new JButton("Eliminar");
        delete.addActionListener(deleteListener);
        delete.setEnabled(false);
        list_bottom.add(delete);

        left.add(list_bottom, BorderLayout.PAGE_END);

        // Listener de valores selecionados na JList
        // Usado para ativar o botão 'Eliminar' se algum valor estiver selecionado e desativá-lo se não
        list.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent listSelectionEvent) {
                if(list.isSelectionEmpty()) {
                    delete.setEnabled(false);
                    count.setEnabled(false);
                }
                else {
                    delete.setEnabled(true);
                    count.setEnabled(true);
                }
            }
        });

        main.add(left);

        JPanel right = new JPanel(new BorderLayout());

        JPanel center_right = new JPanel(new GridLayout(3,1));

        JPanel verify = new JPanel();
        verify.add(new JLabel("Para verificar a existência de um ficheiro"));
        verify.add(new JLabel("no diretório, prima o botão abaixo."));

        JButton pick = new JButton("Escolher Ficheiro");
        pick.addActionListener(verifyListener);
        verify.add(pick);

        JPanel duplicates = new JPanel();
        duplicates.add(new JLabel("Para verificar a existência de ficheiros"));
        duplicates.add(new JLabel("duplicados, prima o botão abaixo."));

        JButton findDuplicates = new JButton("Encontrar Duplicados");
        findDuplicates.addActionListener(duplicatesListener);
        duplicates.add(findDuplicates);

        center_right.add(verify);
        center_right.add(duplicates);
        center_right.setBorder(new EmptyBorder(100,0,10,0));

        right.add(center_right, BorderLayout.CENTER);

        JPanel bottom_right = new JPanel();
        JPanel size = new JPanel(new GridLayout(2,1));
        size.add(new JLabel("Tamanho aproximado do diretório: "));
        JPanel jp = new JPanel();
        numShingles = new JLabel("0");
        jp.add(numShingles);
        size.add(jp);
        bottom_right.add(size);

        center_right.add(bottom_right, BorderLayout.PAGE_END);

        main.add(right);

        JPanel pageTitle = new JPanel();
        pageTitle.add(new JLabel("Diretório: " + dir.getAbsolutePath() + "     "));

        JButton restart = new JButton("Alterar");
        restart.addActionListener(start);
        pageTitle.add(restart);

        panel.add(pageTitle, BorderLayout.PAGE_START);
        panel.add(main, BorderLayout.CENTER);
        return panel;
    }

    // Atualizar JList com o conteúdo da lista de ficheiros inseridos e os campos relativos ao contador estocástico
    public static void update(){
        list.setListData(directoryTools.getDocuments().toArray(new Document[directoryTools.getDocuments().size()]));
        numShingles.setText(String.format("%s B (%.2f MB)", directoryTools.getCounterResult(), (double) directoryTools.getCounterResult() / 1000000.0));
        frame.validate();
        frame.repaint();
    }
}
