# %%

from datetime import datetime
import requests
import pandas as pd
import matplotlib.pyplot as plt
import yfinance as yf



def draw_graph(ticker, df):
    if df.empty:
        print("데이터를 가져오지 못했습니다. 티커명을 확인해 주세요.")
        return

    # 20/50일 이동평균선 계산
    df["MA20"] = df["Close"].rolling(window=20).mean()
    df["MA50"] = df["Close"].rolling(window=50).mean()
    df["MA120"] = df["Close"].rolling(window=120).mean()

    plt.rc("font", size=16)
    plt.figure(figsize=(12, 6))
    
    # 주가(종가) 데이터 시각화
    plt.plot(df.index, df["Close"], color="royalblue", linewidth=1.5, label="Close Price")
    # 20/50일 이동평균선 추가
    plt.plot(df.index, df["MA20"], color="darkorange", linewidth=1.5, alpha=0.5, label="20-Day Moving Avg")
    plt.plot(df.index, df["MA50"], color="darkgreen", linewidth=1.5, alpha=0.5, label="50-Day Moving Avg")
    plt.plot(df.index, df["MA120"], color="darkmagenta", linewidth=1.5, alpha=0.5, label="120-Day Moving Avg")

    # 가장 최근 날짜의 정보만 추가로 출력
    today = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
    last_row = df.iloc[-1]
    xpos = int(len(df) / 3) - 20 if int(len(df) / 2) >= 20 else int(len(df) / 2)
    ypos = df["Close"].max() - (df["Close"].max() - df["Close"].min())/8

    plt.text(
        df.index[xpos],
        ypos,
        f"* Date: {last_row.name.date()}\n* Close Price: ${last_row.loc["Close"]:0.2f}\n* Generated: {today}\n\n",
        verticalalignment="center",
    )

    plt.title(f"Stock Price: {ticker}", pad=15)
    plt.xlabel('Date')
    plt.ylabel('Price (USD)')
    plt.grid(True, linestyle='--', alpha=0.6)
    plt.legend(loc='upper left')
    
    plt.tight_layout()
    plt.savefig(f"{ticker}.png", dpi=300, bbox_inches="tight")
    plt.show()

def main():
    tickers = ["NVDA", "GOOG"]
    df = yf.download(tickers, period="2y", interval="1d")

    for ticker in tickers:
        df_each = df.xs(ticker, level="Ticker", axis=1)
        draw_graph(ticker, df_each)

if __name__ == "__main__":
    main()
