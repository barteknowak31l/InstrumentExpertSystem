package instrumenty;
import javax.swing.*; 
import java.awt.*; 
import java.awt.event.*; 
import java.text.BreakIterator;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;
 
import CLIPSJNI.*;


class InstrumentExpertSystem implements ActionListener
  {  
   JLabel displayLabel;
   JButton nextButton;
   JPanel choicesPanel;
   ButtonGroup choicesButtons;
   ResourceBundle resources;
 
   Environment clips;
   boolean isExecuting = false;
   Thread executionThread;
      
   InstrumentExpertSystem()
     {  
      try
        {
         resources = ResourceBundle.getBundle("resources.resources",Locale.getDefault());
        }
      catch (MissingResourceException mre)
        {
         mre.printStackTrace();
         return;
        }
     
      JFrame jfrm = new JFrame(resources.getString("Tytul"));  
        
      jfrm.getContentPane().setLayout(new GridLayout(3,1));  
     
      jfrm.setSize(480,300);  
  
     
      jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
      
      JPanel displayPanel = new JPanel(); 
      displayLabel = new JLabel();
      displayPanel.add(displayLabel);
     
      choicesPanel = new JPanel(); 
      choicesButtons = new ButtonGroup();

      JPanel buttonPanel = new JPanel(); 
      
      
      nextButton = new JButton(resources.getString("Next"));
      nextButton.setActionCommand("Next");
      buttonPanel.add(nextButton);
      nextButton.addActionListener(this);
      
      jfrm.getContentPane().add(displayPanel); 
      jfrm.getContentPane().add(choicesPanel); 
      jfrm.getContentPane().add(buttonPanel); 

      clips = new Environment();
      
      clips.load("wnioskowanie.clp");
      
      clips.reset();
      runClips();
      
      jfrm.setVisible(true);  
     }  

   private void nextUIState() throws Exception
     {
      String evalStr = "(find-all-facts ((?f send-to-java)) TRUE)";
      
      String wynik = clips.eval(evalStr).get(0).getFactSlot("wynik").toString();
      
      
      if (wynik.equals("Tak"))
        { 
         nextButton.setActionCommand("Restart");
         nextButton.setText(resources.getString("Restart")); 

        }
      else
        { 
         nextButton.setActionCommand("Next");
         nextButton.setText(resources.getString("Next"));
        }
      
      
      PrimitiveValue ileOdpowiedzi = clips.eval(evalStr).get(0).getFactSlot("ile");
      
      choicesPanel.removeAll();
      choicesButtons = new ButtonGroup();
            
     
      for (int i = 0; i < ileOdpowiedzi.intValue(); i++) 
        {
         JRadioButton rButton;
         String odpowiedz = clips.eval(evalStr).get(0).getFactSlot("odp"+(i+1)).toString();       
      
         rButton = new JRadioButton(resources.getString(odpowiedz), i == 0); 
         rButton.setActionCommand(odpowiedz);
         choicesPanel.add(rButton);
         choicesButtons.add(rButton);
         
        }
        
      choicesPanel.repaint();
      
      String tresc = clips.eval(evalStr).get(0).getFactSlot("tresc").toString();     
      wrapLabelText(displayLabel,resources.getString(tresc));
      
      executionThread = null;
      
      isExecuting = false;
     }

   public void actionPerformed(
     ActionEvent ae) 
     { 
      try
        { onActionPerformed(ae); }
      catch (Exception e)
        { e.printStackTrace(); }
     }
 
   public void runClips()
     {
      Runnable runThread = 
         new Runnable()
           {
            public void run()
              {
               clips.run();
               SwingUtilities.invokeLater(
                  new Runnable()
                    {
                     public void run()
                       {
                        try 
                          { nextUIState(); }
                        catch (Exception e)
                          { e.printStackTrace(); }
                       }
                    });
              }
           };
      
      isExecuting = true;
      
      executionThread = new Thread(runThread);
      
      executionThread.start();
     }

   public void onActionPerformed(
     ActionEvent ae) throws Exception 
     { 
      if (isExecuting) return;
      
      String evalStr = "(find-all-facts ((?f send-to-java)) TRUE)";
      String asercja = clips.eval(evalStr).get(0).getFactSlot("asercja").toString();
      
      if (ae.getActionCommand().equals("Next"))
        {
    	  
    	  clips.assertString(resources.getString("AssertCzekaj"));
    	  
          if (choicesButtons.getButtonCount() == 0)
          { 
        	  clips.assertString("("+asercja+")"); 
          }
          else
          {
              clips.assertString("(" + asercja + " " +
                      choicesButtons.getSelection().getActionCommand() + 
                      ")");  
          }
            runClips();
        }
      else if (ae.getActionCommand().equals("Restart"))
        { 
         clips.reset(); 
         runClips();
        }

     }

   private void wrapLabelText(
     JLabel label, 
     String text) 
     {
      FontMetrics fm = label.getFontMetrics(label.getFont());
      Container container = label.getParent();
      int containerWidth = container.getWidth();
      int textWidth = SwingUtilities.computeStringWidth(fm,text);
      int desiredWidth;

      if (textWidth <= containerWidth)
        { desiredWidth = containerWidth; }
      else
        { 
         int lines = (int) ((textWidth + containerWidth) / containerWidth);
                  
         desiredWidth = (int) (textWidth / lines);
        }
                 
      BreakIterator boundary = BreakIterator.getWordInstance();
      boundary.setText(text);
   
      StringBuffer trial = new StringBuffer();
      StringBuffer real = new StringBuffer("<html><center>");
   
      int start = boundary.first();
      for (int end = boundary.next(); end != BreakIterator.DONE;
           start = end, end = boundary.next())
        {
         String word = text.substring(start,end);
         trial.append(word);
         int trialWidth = SwingUtilities.computeStringWidth(fm,trial.toString());
         if (trialWidth > containerWidth) 
           {
            trial = new StringBuffer(word);
            real.append("<br>");
            real.append(word);
           }
         else if (trialWidth > desiredWidth)
           {
            trial = new StringBuffer("");
            real.append(word);
            real.append("<br>");
           }
         else
           { real.append(word); }
        }
   
      real.append("</html>");
   
      label.setText(real.toString());
     }
     
   public static void main(String args[])
     {  
      // Create the frame on the event dispatching thread.  
      SwingUtilities.invokeLater(
        new Runnable() 
          {  
           public void run() { new InstrumentExpertSystem(); }  
          });   
     }  
  }