/*           changeButtonOnTap
                ? Container(
                    width: 80,
                    height: 25,
                    child: FlatButton(
                      onPressed: () {
                        Provider.of<AddItem>(context, listen: false)
                            .addCardManager(widget.name, widget.name,
                                widget.mrp, widget.quantity, widget.type);
                        setState(() {
                          changeButtonOnTap = false;
                        });
                      },
                      color: Color(0xffFF6200),
                      child: Text("Add",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xffffffff),
                          )),
                    ),
                  )
                : Container(
                    height: 25.00,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xffFF6200),
                      borderRadius: BorderRadius.circular(30.00),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {                                          <-----here i need to make change
                              Provider.of<AddItem>(context, listen: false)
                                  .updateTask(Provider.of<AddItem>(context,
                                          listen: false)
                                      .tasks[0]);
                              setState(() {
                                value++;
                                print(Provider.of<AddItem>(context,
                                        listen: false)
                                    .newDataCount);
                              });
                            },
                            child: Icon(Icons.add_circle,
                                color: Colors.white)),
                        Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              value >= 2 ? value-- : null;
                            });
                          },
                          child: Icon(
                            Icons.do_not_disturb_on,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
 */