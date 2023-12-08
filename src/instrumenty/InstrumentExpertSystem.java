package instrumenty;
import javax.swing.*; 
import javax.swing.border.*; 
import javax.swing.table.*;
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
      
      /*================================*/
      /* Create a new JFrame container. */
      /*================================*/
     
      JFrame jfrm = new JFrame(resources.getString("Tytul"));  
 
      /*=============================*/
      /* Specify FlowLayout manager. */
      /*=============================*/
        
      jfrm.getContentPane().setLayout(new GridLayout(3,1));  
 
      /*=================================*/
      /* Give the frame an initial size. */
      /*=================================*/
     
      jfrm.setSize(350,200);  
  
      /*=============================================================*/
      /* Terminate the program when the user closes the application. */
      /*=============================================================*/
     
      jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
 
      /*===========================*/
      /* Create the display panel. */
      /*===========================*/
      
      JPanel displayPanel = new JPanel(); 
      displayLabel = new JLabel();
      displayPanel.add(displayLabel);
      
      /*===========================*/
      /* Create the choices panel. */
      /*===========================*/
     
      choicesPanel = new JPanel(); 
      choicesButtons = new ButtonGroup();
      
      /*===========================*/
      /* Create the buttons panel. */
      /*===========================*/

      JPanel buttonPanel = new JPanel(); 
      
      
      nextButton = new JButton(resources.getString("Next"));
      nextButton.setActionCommand("Next");
      buttonPanel.add(nextButton);
      nextButton.addActionListener(this);
     
      /*=====================================*/
      /* Add the panels to the content pane. */
      /*=====================================*/
      
      jfrm.getContentPane().add(displayPanel); 
      jfrm.getContentPane().add(choicesPanel); 
      jfrm.getContentPane().add(buttonPanel); 

      /*========================*/
      /* Load the program. */
      /*========================*/
      
      clips = new Environment();
      
      clips.load("wnioskowanie.clp");
      
      clips.reset();
      runClips();

      /*====================*/
      /* Display the frame. */
      /*====================*/
      
      jfrm.setVisible(true);  
     }  

   /****************/
   /* nextUIState: */
   /****************/  
   private void nextUIState() throws Exception
     {
      /*=====================*/
      /* Get the send-to-java. */
      /*=====================*/
	   System.out.println(System.getProperty("java.library.path"));
	   
       // Pobranie listy faktów w środowisku Clips
	   //System.out.println("FAKTY");
       //PrimitiveValue factList = clips.eval("(facts)");
       //System.out.println(factList);
       
	   //System.out.println("AGENDA");
       //PrimitiveValue agenda = clips.eval("(agenda)");
       //System.out.println(agenda);
	   
      
      String evalStr = "(find-all-facts ((?f send-to-java)) TRUE)";
      
      String wynik = clips.eval(evalStr).get(0).getFactSlot("wynik").toString();
      System.out.println(wynik);
      
      /*========================================*/
      /* Determine the Next button state. */
      /*========================================*/
      
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
      
      /*=====================*/
      /* Set up the choices. */
      /*=====================*/
      
      PrimitiveValue ileOdpowiedzi = clips.eval(evalStr).get(0).getFactSlot("ile");
      System.out.println(ileOdpowiedzi);
      
      choicesPanel.removeAll();
      choicesButtons = new ButtonGroup();
            
     
      for (int i = 0; i < ileOdpowiedzi.intValue(); i++) 
        {
         JRadioButton rButton;
         String odpowiedz = clips.eval(evalStr).get(0).getFactSlot("odp"+(i+1)).toString();
         System.out.println(odpowiedz);         
      
         rButton = new JRadioButton(resources.getString(odpowiedz), i == 0); 
         rButton.setActionCommand(odpowiedz);
         choicesPanel.add(rButton);
         choicesButtons.add(rButton);
         
        }
        
      choicesPanel.repaint();
      
      /*====================================*/
      /* Set the label to the display text. */
      /*====================================*/
      String tresc = clips.eval(evalStr).get(0).getFactSlot("tresc").toString();
      System.out.println(tresc);       
      wrapLabelText(displayLabel,resources.getString(tresc));
      
      executionThread = null;
      
      isExecuting = false;
     }

   /*########################*/
   /* ActionListener Methods */
   /*########################*/

   /*******************/
   /* actionPerformed */
   /*******************/  
   public void actionPerformed(
     ActionEvent ae) 
     { 
      try
        { onActionPerformed(ae); }
      catch (Exception e)
        { e.printStackTrace(); }
     }
 
   /***********/
   /* runClips */
   /***********/  
   public void runClips()
     {
      Runnable runThread = 
         new Runnable()
           {
            public void run()
              {
            	System.out.println("run clips");
               clips.run();
               System.out.println("run clips ended");
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

   /*********************/
   /* onActionPerformed */
   /*********************/  
   public void onActionPerformed(
     ActionEvent ae) throws Exception 
     { 
      if (isExecuting) return;
      
      /*=====================*/
      /* Get the send-to-java */
      /*=====================*/
      
      String evalStr = "(find-all-facts ((?f send-to-java)) TRUE)";
      String asercja = clips.eval(evalStr).get(0).getFactSlot("asercja").toString();
          
      /*=========================*/
      /* Handle the Next button. */
      /*=========================*/
      
      if (ae.getActionCommand().equals("Next"))
        {
    	  
    	  System.out.println("Wcisnieto next");
    	  clips.assertString(resources.getString("AssertCzekaj"));
    	  
          if (choicesButtons.getButtonCount() == 0)
          { 
        	  clips.assertString("("+asercja+")"); 
        	  System.out.println(asercja);
          }
          else
          {
              clips.assertString("(" + asercja + " " +
                      choicesButtons.getSelection().getActionCommand() + 
                      ")");  
              
              System.out.println("(" + asercja + " " +
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

   /*****************/
   /* wrapLabelText */
   /*****************/  
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