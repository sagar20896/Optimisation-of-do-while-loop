int installID(char *);
enum class tokentype
{  
    ID,OP,SYM,NUM
};  
  
struct identifier
{  
	char* token_name;
	int value;
	char* type;
	int line_no;
	char* data_type;
	int scope;
	
};  
  
struct operators
{
	char* token_name;
	int line_no;
	//int scope;
	
};  

struct symbol
{   
	char* token_name;
	int line_no;
	//int scope;
	
};  

struct number
{   
	char* token_name;
	int line_no;
	//int scope;
};


struct Input  
{  
    tokentype type;  
    union  
    {  
        identifier id;  
        operators op;  
        symbol sym;
        number num;
    };  
};  

void Initialize_id(char* name,char* token_name,int value,char* type,int line_no,char* data_type,int scope);

void Initialize_op(char* name,char* token_name,int line_no) ;

void Initialize_sym(char* name,char* token_name,int line_no);
void Initialize_num(char* name,char* token_name,int line_no); 

template<typename t>
void disp(t a);
template<typename ptr_t>
void display(ptr_t first, ptr_t last);
