package commInfra;

import java.io.Serializable;

/**
 *  Data type to return both a boolean and an integer state value.
 *
 *  Used in calls on remote objects.
 */

public class ReturnValue implements Serializable
{
	  /**
	   *  Serialization key.
	   */

	  private static final long serialVersionUID = 1L;

	  /**
	   *  Boolean value.
	   */

	   private boolean value;

	  /**
	   *  Integer state value.
	   */

	   private int state;

	  /**
	   *  Return Boolean instantiation.
	   *
	   *     @param value boolean value
	   *     @param state integer state value
	   */

	   public ReturnValue (boolean value, int state)
	   {
	      this.value = value;
	      this.state = state;
	   }

	  /**
	   *  Getting boolean value.
	   *
	   *     @return boolean value
	   */

	   public boolean getBooleanValue ()
	   {
	      return (value);
	   }

	  /**
	   *  Getting integer state value.
	   *
	   *     @return integer state value
	   */

	   public int getStateValue ()
	   {
	      return (state);
	   }

}
