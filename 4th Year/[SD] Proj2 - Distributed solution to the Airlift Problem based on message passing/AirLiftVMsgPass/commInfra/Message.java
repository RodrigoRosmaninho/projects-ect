package commInfra;

import java.io.Serializable;

/**
 *   Message Format
 *
 *   Communication is based on message passing over sockets using the TCP protocol.
 *   This class represent the format of a well structured message on our problem.
 *   All the fields are used to implement a general message.
 */

public class Message implements Serializable{
    
    /**
	 *  Serial ID
	 */
	
	private static final long serialVersionUID = 1L;

	
	/**
	 *  Operation that was called
	 */
	
	int operation;
    
	/**
	 *  Generic Array of the operation parameters 
	 */
	
    Object[] params;
    
    /**
	 *  Size of the Generic Array of the operation parameters 
	 */
    
    int size_params;
    
    /**
	 *  Generic Array for the fields that identify the entity 
	 */
    
    Object[] state_fields;
    
    /**
	 *  Size of the Generic Array of the operation parameters 
	 */
    
    int size_state_fields;
    
    /**
	 *  Generic Return field
	 */
    
    Object return_value;
    
    /**
     *  Instantiation of a Message.
     *
     *    @param operation field where the function called is coded
     *    @param params array to store all the parameters needed for the correct execution of the operation
     *    @param size_params number of parameters that are needed by the operation
     *    @param state_fields array to store all the attributes related to the entity that calls the operation
     *    @param size_state_fields numbers of attributes from the entity needed for the correct execution of the operation
     *    @param return_value fields to store the result from the operation
     */
    
    public Message(int operation, Object[] params, int size_params, Object[] state_fields, int size_state_fields, Object return_value){
        this.operation = operation;
        this.params = params;
        this.size_params = size_params;
        this.state_fields = state_fields;
        this.size_state_fields = size_state_fields;
        this.return_value = return_value;
    }
    
    /**
     *   Set Message Operation.
     *
     *     @param operation Message operation
     */
    
    public void setOperation(int operation) {
         this.operation = operation;
    }
    
    /**
     *   Get Message operation.
     *
     *     @return Message Operation.
     */
    
    public int getOperation() {
        return operation;
    }
    
    /**
     *   Set Message Parameters.
     *
     *     @param params Message parameters.
     */
    
    public void setParams(Object[] params) {
        this.params = params;
    }
    
    /**
     *   Get Message parameters.
     *
     *     @return Message Parameters.
     */
    
    public Object[] getParams() {
        return params;
    }
    
    /**
     *   Set the number of parameters.
     *
     *     @param size_params Parameters_Size.
     */
    
    public void setSizeParams(int size_params) {
        this.size_params = size_params;
    }
    
    /**
     *   Get the number of parameters.
     *
     *     @return Message Parameters_Size.
     */
    
    public int getSizeParams() {
        return size_params;
    }
    
    /**
     *   Set Message Attributes.
     *
     *     @param state_fields Message Attributes.
     */
    
    public void setStateFields(Object[] state_fields) {
        this.state_fields = state_fields;
    }
    
    /**
     *   Get Message attributes.
     *
     *     @return Message Attributes.
     */
    
    public Object[] getStateFields() {
        return state_fields;
    }
    
    /**
     *   Set the number of attributes.
     *
     *     @param size_state_fields Attributes_Size.
     */
    
    public void setSizeStateFields(int size_state_fields) {
        this.size_state_fields = size_state_fields;
    }
    
    /**
     *   Get the number of attributes.
     *
     *     @return Message Attributes_Size.
     */

    public int getSizeStateFields() {
        return size_state_fields;
    }
    
    /**
     *   Set the result from the operation.
     *
     *     @param return_value Message Return.
     */
    
    public void setReturnValue(Object return_value) {
        this.return_value = return_value;
    }
    
    /**
     *   Get the result from the operation.
     *
     *     @return Message Return.
     */
    
    public Object getReturnValue() {
        return return_value;
    }


}