from fastapi import FastAPI
import uvicorn
import pickle
import os

app = FastAPI()

@app.get("/ping")
def ping():
    return {"Hello": "World"}


@app.post("/invocations")
def transformation():
    body = "fuga"
    print("start")
    model = None

    print("== start ls ========")
    # for file in os.listdir("/opt/ml/model"):
    #     print(file)
    #print("====================")

    # with open("/opt/ml/model/model.pkl", "rb") as f_model:
    #     model = pickle.load(f_model)

    # model.predict(body)

    print(f"Body: {body}")

    return {"invocated": body}


if __name__ == "__main__":
    uvicorn.run(
        "app:app",
        host="0.0.0.0",
        port=8080
    )
