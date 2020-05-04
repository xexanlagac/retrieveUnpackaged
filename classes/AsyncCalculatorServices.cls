//Generated wsdl2apex

public class AsyncCalculatorServices {
    public class doDivideResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            calculatorServices.doDivideResponse response = (calculatorServices.doDivideResponse)System.WebServiceCallout.endInvoke(this);
            system.debug('test'); 
            system.debug('test'); 
            return response.return_x;
        }
    }
    public class doSubtractResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            calculatorServices.doSubtractResponse response = (calculatorServices.doSubtractResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class doMultiplyResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            calculatorServices.doMultiplyResponse response = (calculatorServices.doMultiplyResponse)System.WebServiceCallout.endInvoke(this);
            system.debug('*');
            return response.return_x;
        }
    }
    public class doAddResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            calculatorServices.doAddResponse response = (calculatorServices.doAddResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class AsyncCalculatorImplPort {
        public String endpoint_x = 'https://th-apex-soap-service.herokuapp.com/service/calculator';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://calculator.services/', 'calculatorServices'};
        public AsyncCalculatorServices.doDivideResponseFuture beginDoDivide(System.Continuation continuation,Double arg0,Double arg1) {
            system.debug('test');
            calculatorServices.doDivide request_x = new calculatorServices.doDivide();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (AsyncCalculatorServices.doDivideResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncCalculatorServices.doDivideResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doDivide',
              'http://calculator.services/',
              'doDivideResponse',
              'calculatorServices.doDivideResponse'}
            );
        }
        public AsyncCalculatorServices.doSubtractResponseFuture beginDoSubtract(System.Continuation continuation,Double arg0,Double arg1) {
            calculatorServices.doSubtract request_x = new calculatorServices.doSubtract();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (AsyncCalculatorServices.doSubtractResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncCalculatorServices.doSubtractResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doSubtract',
              'http://calculator.services/',
              'doSubtractResponse',
              'calculatorServices.doSubtractResponse'}
            );
        }
        public AsyncCalculatorServices.doMultiplyResponseFuture beginDoMultiply(System.Continuation continuation,Double arg0,Double arg1) {
            calculatorServices.doMultiply request_x = new calculatorServices.doMultiply();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (AsyncCalculatorServices.doMultiplyResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncCalculatorServices.doMultiplyResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doMultiply',
              'http://calculator.services/',
              'doMultiplyResponse',
              'calculatorServices.doMultiplyResponse'}
            );
        }
        public AsyncCalculatorServices.doAddResponseFuture beginDoAdd(System.Continuation continuation,Double arg0,Double arg1) {
            calculatorServices.doAdd request_x = new calculatorServices.doAdd();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (AsyncCalculatorServices.doAddResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncCalculatorServices.doAddResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doAdd',
              'http://calculator.services/',
              'doAddResponse',
              'calculatorServices.doAddResponse'}
            );
        }
    }
}